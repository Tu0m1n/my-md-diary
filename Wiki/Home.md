# 🐇🌕 My Markdown Diary 🥚❤️— Journal Nomade en Bash

Bienvenue dans **My Markdown Diary**, alias `mmdd.sh`, un petit compagnon de terminal pour celles et ceux qui aiment écrire, penser, documenter… en Markdown.

Ce script Bash permet de tenir un journal personnel **simple, structuré, et chiffrable** :

- ✍️ Écriture libre et fluide
- 🔐 Chiffrement automatique des notes sensibles
- 🧠 Aide-mémoire quotidien, rapide à consulter
- ⭐ Favoris, tags, recherche, export…
- 🧭 100% nomade, fonctionne sur Linux, WSL, Termux
- 🥷 Avec la collaboration d’un drôle de lapin ninja 🍳

> Il s’installe en une commande, fonctionne partout, et n’exige aucun compte ni service tiers.

---

## 🌱 Principales fonctionnalités

| Commande        | Utilité principale                         |
| --------------- | ------------------------------------------ |
| `-e, --edit`    | Éditer le journal du jour                  |
| `-t, --tag`     | Ajouter une note taggée                    |
| `-s, --star`    | Marquer une note comme favorite (\_fav.md) |
| `-E, --encrypt` | Chiffrer une note sensible                 |
| `-D, --decrypt` | Déchiffrer une note GPG                    |
| `-d, --delete`  | Supprimer ou vider un fichier .md          |
| `-f, --search`  | Rechercher une expression                  |
| `-r, --random`  | Lire une note aléatoire                    |
| `-a, --stats`   | Afficher le nombre de notes, lignes, mots  |
| `-x, --export`  | Exporter les notes au format txt/html/json |
| `-y, --sync`    | Synchroniser le journal avec Git           |
| `-z, --doctor`  | Diagnostic de l’environnement              |

---

## 🔧 Configuration rapide

Tout est paramétrable depuis `~/.mmddrc` :

```bash
DIARY_EDITOR="vim"         # Ou zettlr, nano, etc.
# PASSPHRASE="..."         # Pour automatiser le chiffrement
```

---

## 📚 Wiki

Chaque fonction possède sa page dédiée :

- [Écrire une note](./Ecrire-une-note) — mode libre, multiligne
- [Ajouter un favori](./Ajouter-un-favori)
- [Chiffrer une note](./Chiffrer-une-note)
- [Déchiffrer une note](./Dechiffrer-une-note)
- [Lire une note aléatoire](./Lire-une-note-aleatoire)
- [Rechercher une note](./Rechercher-une-note)
- [Supprimer une note](./Supprimer-une-note)
- [Diagnostic du système](./Diagnostic-mmdd)

---

## 📥 Installation

```bash
git clone https://github.com/Tu0m1n/my-md-diary.git
cd my-md-diary
chmod +x mmdd.sh
cp .mmddrc ~/.mmddrc
```

Et lancez :

```bash
./mmdd.sh "Ceci est ma première note !"
```

---

## ❤️ Philosophie

> Un outil d’écriture qui respecte vos silences.\
> Un espace de réflexion qui tient dans un terminal.\
> Une mémoire que vous contrôlez, chez vous, hors-ligne.\
> Et un compagnon 🥷 discret, 🌕 rêveur, ❤️ tendre, qui cache peut-être un 🥚 dans son terminal.

Fait par [Tu0m1n](https://github.com/Tu0m1n).


