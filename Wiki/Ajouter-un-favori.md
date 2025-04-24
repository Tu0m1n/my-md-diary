# ⭐ Ajouter un favori

Certains fragments de pensée méritent d’être retrouvés plus facilement.  
La commande **--star** permet de marquer une note `.md` comme **favori**, en créant une copie renommée.

---

## 🚀 Commande rapide

```bash
./my-md-diary.sh --star nom_du_fichier.md
```

ou plus court :

```bash
./my-md-diary.sh -s nom_du_fichier.md
```

> Le fichier doit exister dans ton dossier de notes.

---

## 🔁 Ce que fait cette commande

- Elle crée une **copie** du fichier `.md`
- Dans le **même dossier**
- Avec le suffixe `_fav` dans le nom du fichier

Par exemple :

```bash
2025-04-23.md → 2025-04-23_fav.md
```

---

## 📁 Où le retrouver ?

Tous les favoris se trouvent **dans le même répertoire que les autres notes** :

```
~/documents/notes/
```

> Il n’y a plus de sous-dossier `favorites/`, tout est centralisé.

---

## 📓 Bon à savoir

- Le fichier original n’est **pas modifié**
- Tu peux ajouter manuellement un `#fav` dans ton contenu si tu veux retrouver les favoris aussi par recherche

---

Un favori, c’est une balise du cœur.  
Pas seulement une technique.  
