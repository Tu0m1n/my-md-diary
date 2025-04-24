# Diagnostic du système (`--doctor`)

La commande `--doctor` ou `-z` permet d’effectuer un **diagnostic rapide de l’environnement d’exécution de mmdd.sh**.

Elle est particulièrement utile pour :
- vérifier que les dépendances sont bien installées
- confirmer le répertoire utilisé
- s’assurer que le fichier du jour est bien généré

---

## ✅ Utilisation

```bash
./mmdd.sh -z
```

---

## 🔍 Exemple de sortie

```bash
Diagnostic mmdd
Répertoire : /mnt/c/Users/tbour/Documents/notes
Fichier du jour : /mnt/c/Users/tbour/Documents/notes/2025-04-24.md
✔ gpg
✔ jq
✔ pandoc
✔ git
```

---

## 🧠 Fonctionnement

La commande vérifie automatiquement la présence des outils suivants :
- `gpg` : chiffrement/déchiffrement
- `jq` : export JSON
- `pandoc` : export HTML
- `git` : synchronisation

Elle vous aide aussi à repérer :
- les erreurs dans le `.mmddrc`
- les permissions ou dossiers manquants

---

**Astuce** : vous pouvez l’exécuter après chaque mise à jour pour vérifier que tout est fonctionnel.


