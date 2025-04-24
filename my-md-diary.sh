#!/bin/bash

# === Couleurs ===
BLD="\e[1m"; RED="\e[31m"; GRN="\e[32m"; YLW="\e[33m"; BLU="\e[34m"; RST="\e[0m"

# === Détection environnement ===
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
  JOURNAL_DIR="/mnt/c/Users/tbour/Documents/notes"
else
  JOURNAL_DIR="$HOME/documents/notes"
fi

FAV_DIR="$JOURNAL_DIR/favorites"
SECURE_DIR="$JOURNAL_DIR/secure"

mkdir -p "$JOURNAL_DIR"

DATE=$(date +%F)
HEURE=$(date +%Hh%M)
FICHIER="$JOURNAL_DIR/$DATE.md"
APO_UNICODE="’"

# === Dépendances ===
deps=(gpg jq pandoc git)
for dep in "${deps[@]}"; do
  if ! command -v $dep >/dev/null 2>&1; then
    echo -e "${YLW}Dépendance manquante : $dep. Installation...${RST}"
    sudo apt-get install -y $dep
  fi
done

# === Préparation fichier du jour ===
if [ ! -s "$FICHIER" ]; then
  echo "# Journal du $DATE" > "$FICHIER"
  echo "" >> "$FICHIER"
fi

# === Fonctions utilitaires ===
corriger_apostrophes() {
  local texte="$1"
  local nb=$(echo "$texte" | grep -o "'" | wc -l)
  local corrige=$(echo "$texte" | sed "s/'/${APO_UNICODE}/g")
  echo "$corrige"
  if [ "$nb" -gt 0 ]; then
    echo "→ $nb correction(s) automatique(s) appliquée(s)." >&2
  fi
}

resolve_filepath() {
  if [[ "$1" == *.md && "$1" != /* && "$1" != ./* ]]; then
    echo "$JOURNAL_DIR/$1"
  else
    echo "$1"
  fi
}

open_editor() {
  WIN_ZETTLR="/mnt/c/Users/tbour/AppData/Local/Programs/Zettlr/Zettlr.exe"
  if [ -x "$WIN_ZETTLR" ]; then
    "$WIN_ZETTLR" "$FICHIER"
  else
    echo "Zettlr non trouvé. Ouverture avec vim."
    vim "$FICHIER"
  fi
}

encrypt_note() {
  texte=$(corriger_apostrophes "$1")
  filename="$JOURNAL_DIR/${DATE}_$(date +%H%M)_secret.gpg"
echo "$texte" | gpg --symmetric --pinentry-mode loopback --cipher-algo AES256 -o "$filename"
  echo -e "${GRN}Note chiffrée enregistrée dans : $filename${RST}"
}

decrypt_note() {
  echo -e "${GRN}Fichiers disponibles :${RST}"
  ls "$JOURNAL_DIR"/*_secret.gpg 2>/dev/null | xargs -n1 basename

  echo ""
  read -p "Nom du fichier (sans .gpg) : " filebase

  if [ -z "$filebase" ]; then
    echo -e "${RED}Erreur : nom de fichier vide.${RST}"
    return 1
  fi

  fichier="$JOURNAL_DIR/$filebase.gpg"
  echo -e "${BLU}→ Fichier recherché : $fichier${RST}"

  if [ -f "$fichier" ]; then
    echo -e "${GRN}Déchiffrement...${RST}"
    gpg --pinentry-mode loopback -d "$fichier"
  else
    echo -e "${RED}Fichier introuvable : $fichier${RST}"
  fi
}

delete_note() {
  filepath=$(resolve_filepath "$2")
  if [ -f "$filepath" ]; then
    read -p "⚠️ Supprimer $filepath ? [y/N] " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      rm "$filepath"
      echo -e "${RED}Fichier supprimé : $filepath${RST}"
    else
      echo "Annulé."
    fi
  else
    echo -e "${RED}Fichier introuvable : $filepath${RST}"
  fi
}

add_note() {
  texte=$(corriger_apostrophes "$1")
  echo "## $HEURE" >> "$FICHIER"
  echo "$texte" >> "$FICHIER"
  echo "" >> "$FICHIER"
  echo "Note ajoutée."
}

add_tag() {
  texte=$(corriger_apostrophes "$1")
  echo "## $HEURE [#$2]" >> "$FICHIER"
  echo "$texte" >> "$FICHIER"
  echo "" >> "$FICHIER"
  echo "Note taggée avec #$2."
}

add_favorite() {
  path=$(resolve_filepath "$1")
  if [ -f "$path" ]; then
    cp "$path" "${path%.md}_fav.md"
    echo -e "${GRN}⭐ Fichier marqué comme favori : $(basename "$path")${RST}"
  else
    echo -e "${RED}Fichier introuvable : $path${RST}"
  fi
}

view_date() {
  read -p "Date (YYYY-MM-DD) : " input_date
  file="$JOURNAL_DIR/$input_date.md"
  [ -f "$file" ] && cat "$file" || echo "Pas de note pour cette date."
}

search_notes() {
  read -p "Mot-clé à chercher : " keyword
  grep -iHn --color "$keyword" "$JOURNAL_DIR"/*.md
}

random_note() {
  find "$JOURNAL_DIR" -name "*.md" | shuf -n 1 | xargs cat
}

show_stats() {
  total=$(find "$JOURNAL_DIR" -name "*.md" | wc -l)
  lines=$(cat "$JOURNAL_DIR"/*.md | wc -l)
  words=$(cat "$JOURNAL_DIR"/*.md | wc -w)
  echo "Fichiers : $total | Lignes : $lines | Mots : $words"
}

export_notes() {
  echo "Format ? [txt/html/json]"
  read -p "> " format
  case $format in
    txt)
      cat "$JOURNAL_DIR"/*.md > "$JOURNAL_DIR/export.txt"
      echo "Exporté : export.txt"
      ;;
    html)
      pandoc "$JOURNAL_DIR"/*.md -o "$JOURNAL_DIR/export.html"
      echo "Exporté : export.html"
      ;;
    json)
      jq -Rn '[inputs | {text: .}]' "$JOURNAL_DIR"/*.md > "$JOURNAL_DIR/export.json"
      echo "Exporté : export.json"
      ;;
    *)
      echo "Format inconnu."
      ;;
  esac
}

sync_notes() {
  if [ ! -d "$JOURNAL_DIR/.git" ]; then
    echo -e "${RED}⚠️ Le dossier $JOURNAL_DIR n'est pas un dépôt Git. Initialisez-le avec : git init${RST}"
    return
  fi
  cd "$JOURNAL_DIR"
  git add .
  git commit -m "Sync $(date +%F_%Hh%M)"
  git push
  echo "Synchronisation Git terminée."
}

lint_notes() {
  echo "Correction des apostrophes dans tous les fichiers…"
  total=0
  for file in "$JOURNAL_DIR"/*.md; do
    nb=$(grep -o "'" "$file" | wc -l)
    if [ "$nb" -gt 0 ]; then
      sed -i "s/'/${APO_UNICODE}/g" "$file"
      echo "→ $file : $nb correction(s)"
      total=$((total + nb))
    fi
  done
  echo "→ Total : $total correction(s)"
}

# === Interface ===
case $1 in
  -e|--edit) open_editor ;;
  -t|--tag) add_tag "$2" "$3" ;;
  -s|--star) add_favorite "$2" ;;
  -E|--encrypt) encrypt_note "$2" ;;
  -D|--decrypt) decrypt_note ;;
  -d|--delete) delete_note "$@" ;;
  -v|--view) view_date ;;
  -f|--search) search_notes ;;
  -r|--random) random_note ;;
  -a|--stats) show_stats ;;
  -x|--export) export_notes ;;
  -l|--lint) lint_notes ;;
  -y|--sync) sync_notes ;;
  -h|--help)
    echo -e "${BLD}Journal Nomade — Aide rapide${RST}\n"
    echo "  ./journal.sh                    Mode libre : écrire une note (fin par Ctrl+D)"
    echo "  -e, --edit                      Ouvrir le journal du jour"
    echo "  -t, --tag "texte" tag             Ajouter une note taggée"
    echo "  -s, --star fichier.md           Marquer une note comme favori (_fav.md)           Ajouter un fichier aux favoris"
    echo "  -E, --encrypt "texte"             Ajouter une note chiffrée (_secret.gpg)           Ajouter une note chiffrée"
    echo "  -D, --decrypt                   Déchiffrer une note chiffrée"
    echo "  -d, --delete fichier.md         Supprimer une note journalière (.md)"
    echo "  -v, --view                      Lire une note par date"
    echo "  -f, --search                    Rechercher une expression"
    echo "  -r, --random                    Lire une note aléatoire"
    echo "  -a, --stats                     Statistiques générales"
    echo "  -x, --export                    Exporter les notes (txt/html/json)"
    echo "  -l, --lint                      Corriger les apostrophes dans les fichiers"
    echo "  -y, --sync                      Synchroniser avec Git"
    echo "  -h, --help                      Afficher cette aide"
    exit 0
    ;;
  "")
    echo -e "${BLD}Mode libre : écrivez votre note (Ctrl+D pour valider)${RST}"
    texte=$(cat)
    [ -n "$texte" ] && add_note "$texte"
    ;;
  *) add_note "$*" ;;
esac
