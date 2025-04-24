# Déchiffrer une note (`--decrypt`)

La commande `--decrypt` ou `-D` permet d'afficher le contenu d’un fichier chiffré créé via `--encrypt`.

Elle vous affiche d’abord la liste des fichiers `.md.gpg` disponibles, puis vous invite à entrer le nom du fichier à ouvrir.

```bash
./mmdd.sh -D
```

Vous devrez saisir le **nom du fichier sans extension** `.gpg`. Par exemple :
```bash
2025-04-24_secret.md
```

---

## 🔐 Passphrase automatique ou interactive

Deux cas possibles :

### 1. Passphrase automatique
Si vous avez défini `PASSPHRASE` dans `.mmddrc`, le fichier est déchiffré directement, sans interaction.

### 2. Saisie manuelle
Si la passphrase n’est pas définie, le script vous demandera une passphrase temporaire de manière sécurisée :
```bash
🔐 Entrez la passphrase de déchiffrement :
```

---

## 📄 Contenu affiché

Le fichier `.md.gpg` contient **toutes les notes chiffrées du jour**, fusionnées dans le même fichier. Le contenu affiché est complet :

```markdown
# Journal du 2025-04-24

## 21h10
Mot de passe Wi-Fi de Mamie

## 22h15
ID de connexion bancaire
```

---

## ✅ Exemple

```bash
./mmdd.sh -D
# → Entrez : 2025-04-24_secret.md
```

> Le script utilise `gpg` avec `--pinentry-mode loopback` pour permettre une exécution en mode ligne de commande uniquement, sans interface graphique.


