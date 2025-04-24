# 🛤️ Roadmap — mmdd.sh

## 🎯 Prochaine version : `v1.1`

### 🔐 Amélioration du chiffrement par défaut
- Actuellement : `PASSPHRASE="..."` dans `.mmddrc` (en clair)
- Objectif : permettre le chiffrement par défaut **sans stocker la passphrase**
- Fonctionnement prévu :
  - Si `DEFAULT_ENCRYPT="yes"` et `PASSPHRASE` vide
  - Demander une fois le mot de passe en début de session (`SESSION_PASSPHRASE`)
  - Réutiliser en mémoire sans jamais écrire
  - Sûr, fluide, et compatible CLI / Termux / WSL

---

### Autres idées envisagées pour `v1.1`

- ✅ `--list` : afficher tous les fichiers de notes disponibles (`.md`, `.gpg`, `_fav.md`)
- 📂 `--template` : injecter un squelette de note (bullet journal, gratitude, etc.)
- 🧼 `--lint` : améliorer la correction des apostrophes + alertes syntaxiques
- 🔁 `--rituel` : mode écriture programmé / notification à heure fixe
- 🧩 Mode plugin : chargement dynamique de scripts dans `~/mmdd.d/`

---

> 🐇 Toute version future restera légère, modulaire, et respectueuse de votre rythme intérieur.


