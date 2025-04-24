# 🗑️ Supprimer une note

Parfois, une note n’a plus lieu d’être.  
Que ce soit une erreur, un test, ou une pensée que l’on souhaite effacer, My MD Diary permet une suppression simple et ciblée.

---

## 🚨 Attention

Cette action est **irréversible**.  
La note est **supprimée du système de fichiers**.

---

## 🛠️ Commande

```bash
./my-md-diary.sh --delete nom_du_fichier.md
```

ou version courte :

```bash
./my-md-diary.sh -d nom_du_fichier.md
```

---

## 🔎 Exemple

```bash
./my-md-diary.sh -d 2025-04-23.md
```

Supprimera le fichier `2025-04-23.md` de ton répertoire `~/documents/notes/`.

---

## ❓ Que peut-on supprimer ?

- Une note journalière (`YYYY-MM-DD.md`)
- Un favori (`*_fav.md`)
- Une note chiffrée (`*_secret.gpg`)  
  *(attention à bien préciser l’extension)*

---

## 🔐 Et les notes chiffrées ?

Tu peux les supprimer **comme n’importe quel fichier**, à condition de connaître leur nom exact.

---

## 💡 Conseil

Fais une sauvegarde Git régulière pour pouvoir revenir en arrière en cas de suppression accidentelle.

---

Effacer, ce n’est pas nier.  
C’est faire de la place pour un silence nouveau.

