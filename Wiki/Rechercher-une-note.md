# 🔍 Rechercher une note

Tu cherches une pensée, une date, un mot oublié ?  
La commande **--search** permet d’explorer toutes tes notes en un clin d’œil.

---

## 🚀 Commande

```bash
./my-md-diary.sh --search
```

ou plus court :

```bash
./my-md-diary.sh -f
```

---

## ✏️ Que se passe-t-il ?

Tu seras invité à entrer une **expression à rechercher**.

Par exemple :

```
Expression à rechercher : sommeil
```

Le script parcourra tous les fichiers `.md` dans ton répertoire de notes  
et affichera toutes les lignes contenant ce mot.

---

## 📁 Où cherche-t-il ?

Dans le dossier configuré (`~/documents/notes/` ou `/mnt/c/...` sous WSL).  
Seuls les fichiers `.md` sont inclus (pas les `.gpg` ni les favoris).

---

## 🧠 Astuces

- Tu peux chercher un **tag**, une date, un mot, un symbole
- La recherche est **sensible à la casse** (ex : `Amour` ≠ `amour`)
- Pour ignorer la casse, tu peux modifier la commande `grep` dans le script

---

## ✨ Exemples

```
./my-md-diary.sh -f
→ Expression à rechercher : lecture
```

```
# Journal du 2025-04-20
## 22h15
J’ai repris la lecture de mon vieux carnet.
```

---

Rechercher dans ses notes,  
C’est comme fouiller dans des poches pleines de souvenirs.

