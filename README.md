# My Markdown Diary (`mmdd.sh`)

> ✨ Un journal local, simple et chiffrable en Markdown. Pour écrire librement, où que vous soyez.

---

## 🌍 Présentation

**mmdd.sh** est un script bash nomade pour tenir un journal personnel en ligne de commande.
- ✍️ Créer et éditer des notes journalières en Markdown
- 🔐 Chiffrer les notes sensibles (fusion journalière possible)
- 🔎 Rechercher, taguer, marquer comme favori
- 🔁 Synchroniser avec Git
- 📤 Exporter facilement

Il est pensé pour fonctionner sur Linux, WSL, Android/Termux, ou tout système Unix.

---

## 🚀 Installation

```bash
git clone https://github.com/Tu0m1n/my-md-diary.git
cd my-md-diary
chmod +x mmdd.sh
cp .mmddrc ~/.mmddrc
alias diary="bash ~/chemin/vers/mmdd.sh"
```

> Personnalisez le fichier `~/.mmddrc` pour configurer vos chemins, éditeur ou passphrase.

---

## 🧠 Dépendances

Le script vérifie automatiquement la présence des outils suivants :
- `gpg`, `jq`, `pandoc`, `git`

S'ils ne sont pas installés, il tentera de les ajouter automatiquement avec `sudo apt install`, ou affichera une commande manuelle adaptée selon l’environnement (`apt`, `pkg`, `proot-distro`).

---

## 🧭 Utilisation rapide

```bash
diary                        # Mode libre (multiligne)
diary -e                     # Éditer le journal du jour
diary "Texte ici"            # Ajouter une note rapide
diary -t "Texte" tag         # Note avec tag
diary -s fichier.md          # Marquer une note comme favori (_fav.md)

diary -E "secret"            # Ajouter une note chiffrée
diary -D                     # Déchiffrer une note
diary -d fichier.md          # Supprimer une note (ou vider si aujourd’hui)

diary -v                     # Lire une note par date
diary -r                     # Lire une note aléatoire
diary -f                     # Rechercher une expression
diary -a                     # Statistiques générales
diary -x                     # Exporter les notes (txt/html/json)
diary -y                     # Synchroniser avec Git
diary -z                     # Diagnostic du système
```

---

## ⚙️ Configuration (`~/.mmddrc`)

```bash
# Répertoire des notes (écrasé si WSL détecté)
# JOURNAL_DIR="$HOME/notes"

# Éditeur par défaut
DIARY_EDITOR="vim"

# Passphrase automatique pour GPG
# PASSPHRASE="MaPhrase"
```

---

## 📌 Commandes supportées

| Commande         | Description                                        |
|------------------|----------------------------------------------------|
| `-e, --edit`     | Ouvrir le journal du jour                          |
| `-t, --tag`      | Ajouter une note avec tag                          |
| `-s, --star`     | Créer une version favorite d’une note              |
| `-E, --encrypt`  | Chiffrer une note (fusion journalière)             |
| `-D, --decrypt`  | Lire une note chiffrée (interactif ou automatique) |
| `-d, --delete`   | Supprimer ou vider un fichier `.md`                |
| `-v, --view`     | Voir une note selon la date                        |
| `-f, --search`   | Rechercher un mot-clé                              |
| `-r, --random`   | Afficher une note aléatoire                        |
| `-a, --stats`    | Statistiques sur les notes                         |
| `-x, --export`   | Exporter les notes                                 |
| `-y, --sync`     | Synchroniser Git                                   |
| `-z, --doctor`   | Diagnostic de l’environnement                      |
| `-h, --help`     | Affiche l’aide                                     |

---

## 📤 Export et synchronisation

- Export possible en `.txt`, `.html`, `.json`
- Synchronisation avec Git dans le dossier de notes

---

## 🔐 Notes chiffrées

- Utilise `gpg` en mode `loopback`
- Stocke les notes dans `YYYY-MM-DD_secret.md.gpg`
- Fusionne automatiquement les notes du jour
- Utilisable avec ou sans passphrase automatique

---

## 📚 Documentation complémentaire

Voir le wiki du dépôt : [Accéder au wiki](https://github.com/Tu0m1n/my-md-diary/wiki)

---

## 📄 Licence

Ce projet est distribué sous la licence **GNU GPLv3** — libre d’utilisation, modification et partage.

---

Fait avec ❤️ par [Tu0m1n](https://github.com/Tu0m1n) — pour ne jamais oublier ce qui compte.

