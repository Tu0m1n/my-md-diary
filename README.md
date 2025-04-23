# My MD Diary

**My MD Diary** est un journal personnel en ligne de commande, local, sécurisé et poétique.  
Il utilise le format Markdown pour une compatibilité maximale et une simplicité de lecture.

---

## ✨ Fonctionnalités

- Écriture libre et multi-ligne (Ctrl+D pour valider)
- Tagging, mise en favoris
- Chiffrement / déchiffrement des notes
- Recherche, stats, export (.txt, .html, .json)
- Correction automatique des apostrophes typographiques
- Synchronisation Git (si configuré)
- Compatible Termux / Linux / WSL
- Système de fichiers intelligent (détection WSL vs Linux natif)

---

## ⚙️ Installation

1. Cloner ou copier le script `my-md-diary.sh`
2. Rendre exécutable :
   ```bash
   chmod +x my-md-diary.sh
   ```
3. Lancer simplement :
   ```bash
   ./my-md-diary.sh
   ```

---

## ✅ Aide rapide

```bash
./my-md-diary.sh                    Mode libre (multi-ligne, Ctrl+D)
-e, --edit                          Ouvrir le journal du jour
-t, --tag "texte" tag               Ajouter une note taggée
-s, --star fichier.md               Ajouter aux favoris
-E, --encrypt "texte"               Ajouter une note chiffrée
-D, --decrypt                       Lire une note chiffrée
-d, --delete fichier.md             Supprimer une note journalière
-v, --view                          Lire une note par date
-f, --search                        Rechercher une expression
-r, --random                        Lire une note aléatoire
-a, --stats                         Voir les statistiques
-x, --export                        Exporter les notes
-l, --lint                          Corriger les apostrophes
-y, --sync                          Synchroniser via Git
-h, --help                          Afficher l’aide
```

---

## 🧪 Dépendances

- `gpg`, `jq`, `pandoc`, `git` (installés automatiquement si manquants)

---

## 🌍 Structure des fichiers

Tous les fichiers sont enregistrés dans un seul dossier :

- `~/documents/notes/` (Linux)
- `/mnt/c/Users/.../Documents/notes/` (WSL)

Ce répertoire contient :
- les notes journalières : `YYYY-MM-DD.md`
- les notes chiffrées : `YYYY-MM-DD_HHMM_secret.gpg`
- les favoris : copies nommées `XXX_fav.md`



---

## ⚠️ Git & Sécurité

Le script vérifie que le répertoire est bien un dépôt Git avant toute tentative de synchronisation.

---

## 🐇 Auteur

Un ninja poète du Markdown et des terminaux nomades.
