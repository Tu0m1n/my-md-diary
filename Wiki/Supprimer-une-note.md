# Supprimer une note (`--delete`)

La commande `--delete` ou `-d` permet de supprimer un fichier de note (.md ou .md.gpg) **de manière sécurisée**, avec une confirmation interactive.

---

## ✋ Sécurité par défaut

Aucune note n’est supprimée directement.
Vous devez confirmer la suppression via une question :

```bash
⚠️ Supprimer 2025-04-24.md ? [y/N]
```

> Si vous tapez `y` ou `Y`, le fichier est effacé.
> Toute autre réponse annule l’opération.

---

## 📅 Journal du jour : comportement protégé

Si vous tentez de supprimer la note du jour (fichier `YYYY-MM-DD.md` pour la date du jour), **le fichier ne sera pas supprimé**, mais simplement vidé.

Exemple de résultat :

```bash
# Journal du 2025-04-24
```

Cela évite la recréation automatique du fichier par le script.

---

## 🔐 Fichiers verrouillés

Si le fichier est ouvert dans un éditeur (ex: Zettlr), le script affichera un message :

```bash
⚠️ Le fichier semble verrouillé ou en lecture seule.
Fermez-le dans votre éditeur puis réessayez.
```

---

## ✅ Utilisation

```bash
./mmdd.sh -d 2025-04-24.md
./mmdd.sh -d 2025-04-24_secret.md.gpg
```

---

## 📌 Limites

- Ne supprime qu’un fichier à la fois
- Ne gère pas encore les suppressions multiples ou en lot
- Fonctionne avec tous les fichiers supportés : `.md`, `.md.gpg`, `_fav.md`, etc.


