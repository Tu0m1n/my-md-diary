# 🧾 Journal des modifications — mmdd.sh

## v1.0 — Première version stable (2025-04-24)

✨ **Fonctionnalités principales** :
- Création et édition de journaux journaliers en Markdown
- Ajout de notes rapides, taguées ou favorites (`-t`, `-s`)
- Mode multiligne libre par défaut
- Fusion automatique des notes chiffrées dans un fichier unique (`-E`)
- Déchiffrement interactif ou automatique selon la passphrase (`-D`)
- Suppression avec confirmation (`-d`) + vidage du journal du jour si besoin
- Lecture par date, recherche, lecture aléatoire (`-v`, `-f`, `-r`)
- Statistiques ligne/mots/fichiers (`-a`)
- Export `.txt`, `.html`, `.json` (`-x`)
- Synchronisation Git (`-y`)
- Diagnostic de l’environnement (`-z`)

🔐 **Chiffrement / Déchiffrement** :
- Support GPG avec passphrase fixe ou saisie dynamique
- Fichiers de type `_secret.md.gpg` fusionnés automatiquement

🧠 **Détection intelligente de l’environnement** :
- Adaptation aux systèmes Linux, WSL, Termux, Proot
- Détection automatique des dépendances avec suggestion ou installation (`apt`, `pkg`, etc.)

📚 **Documentation** :
- Wiki complet pour chaque commande (+ exemples et formats)
- README clair, formaté, avec alias & personnalisation `.mmddrc`
- Pages poétiques 🌕🐇❤️🥚 (lapin ninja inside)

🧼 **Robustesse** :
- Correction des apostrophes automatiques
- Tests complets sur tous les cas d’usage (favoris, encodage, export, Git)

---

> Première pierre posée pour un compagnon d’écriture local, libre, et respectueux de votre rythme.


