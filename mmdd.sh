#!/bin/bash

# === Couleurs ===
BLD="\e[1m"; RED="\e[31m"; GRN="\e[32m"; YLW="\e[33m"; BLU="\e[34m"; RST="\e[0m"
APO_UNICODE="’"

# === Chargement config ===
CONFIG="$HOME/.mmddrc"
[ -f "$CONFIG" ] && source "$CONFIG"

# === Détection environnement ===
if [ -z "$JOURNAL_DIR" ]; then
  if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
      if [ -z "$WIN_USER" ]; then
        WIN_USER=$(ls /mnt/c/Users 2>/dev/null | grep -v 'Public\\|Default' | head -n 1)
      fi
    JOURNAL_DIR="/mnt/c/Users/$WIN_USER/Documents/notes"
  else
    JOURNAL_DIR="$HOME/notes"
  fi
fi

# === Détection et installation des dépendances ===

check_dependencies() {
  deps=(gpg jq pandoc git)

  # Détection environnement
  if grep -qi "termux" <<< "$PREFIX"; then
    INSTALL_CMD="pkg install"
  elif [ -f "/etc/proot-distro" ] || grep -qi "proot" <<< "$(uname -a)"; then
    INSTALL_CMD="apt install"
  elif grep -qiE "(Microsoft|WSL)" /proc/version; then
    INSTALL_CMD="sudo apt install"
  else
    INSTALL_CMD="sudo apt install"
  fi

  for dep in "${deps[@]}"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
      echo -e "${YLW}🔧 Dépendance manquante : $dep${RST}"
      if command -v sudo >/dev/null 2>&1; then
        echo -e "${BLU}→ Installation automatique avec : $INSTALL_CMD $dep${RST}"
        $INSTALL_CMD -y "$dep"
      else
        echo -e "${RED}✘ sudo non disponible. Installation manuelle requise.${RST}"
        echo -e "${BLD}→ Exécutez :${RST} $INSTALL_CMD $dep"
      fi
    fi
  done
}

mkdir -p "$JOURNAL_DIR"

DATE=$(date +%F)
HEURE=$(date +%Hh%M)
FICHIER="$JOURNAL_DIR/$DATE.md"

# === Dépendances ===
deps=(gpg jq pandoc git)
for dep in "${deps[@]}"; do
  if ! command -v $dep >/dev/null 2>&1; then
    echo -e "${YLW}Installation de $dep...${RST}"
    sudo apt-get install -y $dep
  fi
done

# === Fichier du jour ===
[ ! -f "$FICHIER" ] && echo -e "# Journal du $DATE\n" > "$FICHIER"

# === Fonctions ===
resolve_filepath() {
  local f="$1"
  if [[ "$f" != /* && "$f" != ./* ]]; then
    echo "$JOURNAL_DIR/$f"
  else
    echo "$f"
  fi
}

corriger_apostrophes() {
  local texte="$1"
  local nb=$(echo "$texte" | grep -o "'" | wc -l)
  local corrige=$(echo "$texte" | sed "s/'/${APO_UNICODE}/g")
  echo "$corrige"
  [ "$nb" -gt 0 ] && echo "→ $nb correction(s) automatique(s) appliquée(s)." >&2
}

add_note() {
  texte=$(corriger_apostrophes "$1")
  echo "## $HEURE" >> "$FICHIER"
  echo "$texte" >> "$FICHIER"
  echo "" >> "$FICHIER"
  echo "Note ajoutée."
}

delete_note() {
  fichier=$(resolve_filepath "$2")

  if [ -z "$fichier" ]; then
    echo -e "${RED}Aucun nom de fichier fourni.${RST}"
    return 1
  fi

  if [ ! -f "$fichier" ]; then
    echo -e "${RED}Fichier introuvable : $fichier${RST}"
    return 1
  fi

  echo -n -e "${YLW}⚠️ Supprimer ${fichier} ? [y/N] ${RST}"
  read confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    if [[ "$fichier" == *"$DATE.md" ]]; then
      if [ ! -w "$fichier" ]; then
        echo -e "${RED}⚠️ Le fichier semble verrouillé ou en lecture seule.${RST}"
        echo "Fermez-le dans votre éditeur puis réessayez."
        return 1
      fi
      echo "# Journal du $DATE" | tee "$fichier" > /dev/null
      echo -e "${GRN}Fichier du jour vidé mais conservé : $fichier${RST}"
    else
      rm "$fichier"
      echo -e "${RED}Fichier supprimé : $fichier${RST}"
    fi
  else
    echo "Suppression annulée."
  fi
}

add_tag() {
  texte=$(corriger_apostrophes "$1")
  echo "## $HEURE [#$2]" >> "$FICHIER"
  echo "$texte" >> "$FICHIER"
  echo "" >> "$FICHIER"
  echo "Note taggée avec #$2."
}

add_favorite() {
  file="$1"
  if [ -z "$file" ]; then
    echo -e "${RED}Erreur : aucun nom de fichier fourni.${RST}"
    return
  fi

  # Ajout uniquement de .md si l’extension est absente
  [[ "$file" != *.md ]] && file="$file.md"

  path=$(resolve_filepath "$file")
  if [ -f "$path" ]; then
    cp "$path" "${path%.md}_fav.md"
    echo -e "${GRN}⭐ Favori créé : ${path%.md}_fav.md${RST}"
  else
    echo -e "${RED}Fichier introuvable : $path${RST}"
  fi
}

open_editor() {
  ${DIARY_EDITOR:-vim} "$FICHIER"
}

encrypt_note() {
  texte=$(corriger_apostrophes "$1")
  fichier="$JOURNAL_DIR/${DATE}_secret.md.gpg"
  echo -e "## $HEURE\n$texte\n" > /tmp/entry

  if [ -f "$fichier" ]; then
    gpg --batch --yes --pinentry-mode loopback --passphrase "$PASSPHRASE" -d "$fichier" > /tmp/decrypted 2>/dev/null
    cat /tmp/decrypted /tmp/entry > /tmp/final
  else
    cp /tmp/entry /tmp/final
  fi

  if [ -z "$PASSPHRASE" ]; then
    echo -n -e "${YLW}🔐 Entrez une passphrase temporaire pour cette note : ${RST}"
    read -s TMP_PASS
    echo
    gpg --batch --yes --pinentry-mode loopback --passphrase "$TMP_PASS" -c -o "$fichier" /tmp/final
    unset TMP_PASS
  else
    gpg --batch --yes --pinentry-mode loopback --passphrase "$PASSPHRASE" -c -o "$fichier" /tmp/final
  fi

  if [ $? -eq 0 ]; then
    echo -e "${GRN}Note chiffrée ajoutée à : $fichier${RST}"
  else
    echo -e "${RED}Erreur : chiffrement échoué.${RST}"
    rm -f "$fichier"
  fi

  rm -f /tmp/entry /tmp/final /tmp/decrypted 2>/dev/null
}

decrypt_note() {
  echo -e "${GRN}Fichiers chiffrés disponibles :${RST}"
  ls "$JOURNAL_DIR"/*.gpg 2>/dev/null | xargs -n1 basename
  echo -n "Nom du fichier (sans .gpg) : "
  read filebase
  fichier="$JOURNAL_DIR/$filebase.gpg"
  echo -e "${BLU}→ Fichier recherché : $fichier${RST}"

  if [ -f "$fichier" ]; then
    if [ -z "$PASSPHRASE" ]; then
      echo -n -e "${YLW}🔐 Entrez la passphrase de déchiffrement : ${RST}"
      read -s TMP_PASS
      echo
      gpg --pinentry-mode loopback --passphrase "$TMP_PASS" -d "$fichier"
      unset TMP_PASS
    else
      gpg --pinentry-mode loopback --passphrase "$PASSPHRASE" -d "$fichier"
    fi
  else
    echo -e "${RED}Fichier introuvable : $fichier${RST}"
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

sync_notes() {
  cd "$JOURNAL_DIR"
  [ ! -d .git ] && echo -e "${RED}Pas un dépôt git${RST}" && return
  git add . && git commit -m "Sync $(date +%F_%Hh%M)" && git push
  echo "Git sync terminé."
}

export_notes() {
  echo "Format ? [txt/html/json]"
  read -p "> " format
  case $format in
    txt) cat "$JOURNAL_DIR"/*.md > "$JOURNAL_DIR/export.txt" && echo "Exporté : export.txt" ;;
    html) pandoc "$JOURNAL_DIR"/*.md -o "$JOURNAL_DIR/export.html" && echo "Exporté : export.html" ;;
    json) jq -Rn '[inputs | {text: .}]' "$JOURNAL_DIR"/*.md > "$JOURNAL_DIR/export.json" && echo "Exporté : export.json" ;;
    *) echo "Format inconnu." ;;
  esac
}

run_doctor() {
  echo -e "${BLU}Diagnostic mmdd${RST}"
  echo "Répertoire : $JOURNAL_DIR"
  echo "Fichier du jour : $FICHIER"
  for d in "${deps[@]}"; do
    command -v $d >/dev/null && echo "✔ $d" || echo "✘ $d manquant"
  done
}

# === Interface ===
case "$1" in
  -e|--edit) open_editor ;;
  -d|--delete) delete_note "$@" ;;
  -t|--tag) add_tag "$2" "$3" ;;
  -s|--star) add_favorite "$2" ;;
  -E|--encrypt) encrypt_note "$2" ;;
  -D|--decrypt) decrypt_note ;;
  -v|--view) view_date ;;
  -f|--search) search_notes ;;
  -r|--random) random_note ;;
  -a|--stats) show_stats ;;
  -x|--export) export_notes ;;
  -y|--sync) sync_notes ;;
  -z|--doctor) run_doctor ;;
  -h|--help)
    echo -e "${BLD}My Markdown Diary — Aide rapide${RST}\n"
    echo "  -e,  --edit            : éditer le journal du jour"
    echo "  -t,  --tag             : ajouter une note taggée"
    echo "  -s,  --star            : marquer une note comme favori"
    echo "  -E,  --encrypt         : ajouter une note chiffrée"
    echo "  -D,  --decrypt         : déchiffrer une note"
    echo "  -v,  --view            : afficher une note par date"
    echo "  -f,  --search          : recherche par mot-clé"
    echo "  -r,  --random          : afficher une note aléatoire"
    echo "  -a,  --stats           : statistiques"
    echo "  -x,  --export          : exporter les notes (txt/html/json)"
    echo "  -y,  --sync            : synchroniser avec Git"
    echo "  -z,  --doctor          : vérification de l'environnement"
    echo "  -h,  --help            : afficher cette aide"
    ;;
  "")
    echo -e "${BLD}Mode libre : écrivez votre note (Ctrl+D)${RST}"
    texte=$(cat)
    [ -n "$texte" ] && add_note "$texte"
    ;;
  *) add_note "$*" ;;
esac

