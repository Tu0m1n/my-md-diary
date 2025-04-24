# 🔓 Déchiffrer une note

Tu as créé une note chiffrée avec `--secure` ou `-c` ?  
Voici comment la retrouver et la lire, en toute sécurité.

---

## 🛠️ Commande

```bash
./my-md-diary.sh --decrypt
```

ou plus court :

```bash
./my-md-diary.sh -D
```

---

## 🔍 Sélection du fichier

Tu seras invité à entrer le **nom de la note chiffrée**, sans l’extension `.gpg`.

Par exemple :

```
Nom du fichier (sans .gpg) : 2025-04-23_1834_secret
```

Le script va chercher ce fichier dans ton répertoire de notes.

---

## 🔐 GPG entre en jeu

Si ta clé privée correspond bien à celle utilisée pour chiffrer, GPG déchiffrera la note.

Tu verras alors son contenu affiché dans le terminal.

> Si ta phrase de passe est requise, GPG te la demandera.

---

## ⚠️ En cas d'erreur

- Vérifie que le fichier `.gpg` existe bien dans `~/documents/notes/`
- Assure-toi que ta **clé GPG** est bien présente dans `gpg --list-keys`
- Le nom demandé ne doit pas contenir `.gpg` à la fin

---

## 🧠 Remarque

Le script n’ouvre pas le fichier dans un éditeur,  
il le déchiffre simplement **en lecture seule**, dans ton terminal.

---

Déchiffrer, ce n’est pas briser un secret.  
C’est lui demander doucement s’il veut bien parler.

