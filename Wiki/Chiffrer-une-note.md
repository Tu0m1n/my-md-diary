# Chiffrer une note (`--encrypt`)

La commande `--encrypt` ou `-E` permet de chiffrer une note directement depuis le terminal.

Chaque note chiffrée est ajoutée à un fichier unique pour la journée :

```
YYYY-MM-DD_secret.md.gpg
```

Ce fichier est automatiquement **fusionné** à chaque nouvelle note chiffrée du même jour.

---

## 🔐 Deux modes de chiffrement

### 1. **Passphrase prédéfinie**

Si vous avez défini `PASSPHRASE` dans votre `.mmddrc`, la note sera automatiquement chiffrée sans interaction :

```bash
PASSPHRASE="motdepasse"  # dans .mmddrc
```

```bash
./mmdd.sh -E "Texte secret"
```

### 2. **Saisie manuelle (interactif)**

Si aucune passphrase n’est définie, le script vous demandera d’en entrer une directement dans le terminal :

```bash
./mmdd.sh -E "Note temporaire protégée"
🔐 Entrez une passphrase temporaire pour cette note :
```

---

## 🧠 Fusion automatique

Toutes les notes chiffrées d’un même jour sont fusionnées dans un seul fichier :

```bash
## 21h10
Mot de passe Wi-Fi de Mamie

## 22h15
ID de connexion bancaire
```

---

## ✅ Exemple

```bash
./mmdd.sh -E "Première note secrète"
./mmdd.sh -E "Deuxième pensée cachée"
```

---

## 📌 Résumé

- Le fichier chiffré est créé automatiquement s’il n’existe pas
- Il est fusionné à chaque nouvelle note via `gpg`
- Vous pouvez choisir entre une passphrase automatique (config) ou une saisie à la volée
- Les fichiers sont stockés dans : `$JOURNAL_DIR/YYYY-MM-DD_secret.md.gpg`

> Vous pouvez déchiffrer ce fichier plus tard avec `--decrypt`.


