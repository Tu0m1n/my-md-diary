# 🔐 Chiffrer une note

Certaines pensées sont plus sensibles.  
Pour ces cas-là, **My MD Diary** permet d’ajouter une note **chiffrée**, lisible uniquement avec ta clé GPG.

---

## 🔧 Prérequis

- Avoir **GnuPG** installé (`gpg`)
- Avoir une **clé GPG** déjà créée (locale)

---

## 🚀 Commande rapide

```bash
./my-md-diary.sh --secure "Ma pensée secrète du jour..."
```

ou avec l’alias court :

```bash
./my-md-diary.sh -c "Texte confidentiel"
```

---

## 📦 Résultat

- Une note est chiffrée immédiatement avec ta clé publique locale
- Le fichier est enregistré avec un nom horodaté, par exemple :

```bash
2025-04-23_1834_secret.gpg
```

> Le chiffrement se fait en local, **sans réseau**, et reste accessible uniquement via `gpg`.

---

## 📁 Où sont stockées les notes chiffrées ?

Dans le même répertoire que les autres :

```
~/documents/notes/
```

---

## 🔐 Déchiffrer une note

Utilise :

```bash
./my-md-diary.sh --decrypt
```

Tu seras invité à choisir un fichier `.gpg`, et GPG te demandera la phrase de passe si nécessaire.

---

## 🧘‍♂️ Pour un usage sain

Ces notes sont vraiment chiffrées.  
Assure-toi de **sauvegarder ta clé GPG** si tu veux y accéder à long terme.  
Sinon, elles sont perdues à jamais.

---

Le secret n’est pas une barrière,  
C’est un écrin.

