# Étapes Git pour finaliser la réorganisation

## ✅ Structure réorganisée avec succès !

La structure du repository est maintenant correcte pour Home Assistant :
- ✅ `repository.json` créé à la racine
- ✅ Tous les fichiers de l'add-on déplacés dans `dozzle-agent/`

## 📋 Commandes Git à exécuter

### 1. Vérifier les changements

```bash
git status
```

Vous devriez voir :
- Nouveau fichier : `repository.json`
- Nouveau dossier : `dozzle-agent/` (avec tous les fichiers)
- Fichiers supprimés : fichiers déplacés depuis la racine

### 2. Ajouter tous les changements

```bash
# Ajouter le nouveau repository.json
git add repository.json

# Ajouter le dossier dozzle-agent/ et son contenu
git add dozzle-agent/

# Ajouter les fichiers supprimés (déplacés)
git add -u
```

**Ou en une seule commande :**
```bash
git add repository.json dozzle-agent/ -A
```

### 3. Commit les changements

```bash
git commit -m "chore: reorganize repository structure for Home Assistant

- Created repository.json at root
- Moved all add-on files to dozzle-agent/ directory
- Repository now follows Home Assistant add-on repository structure"
```

### 4. Push vers GitHub

```bash
git push origin main
```

## 🎯 Après le push

1. **Vérifier sur GitHub** que la structure est correcte
2. **Tester l'ajout du repository** dans Home Assistant :
   ```
   https://github.com/Erreur32/homeassistant-dozzle-agent
   ```
3. Le repository devrait maintenant être reconnu comme valide !

## 📝 Note sur les fichiers temporaires

Les fichiers suivants peuvent être supprimés ou gardés (au choix) :
- `COMMIT_MESSAGE.md` - Guide de commit (peut être supprimé)
- `RELEASE_GUIDE.md` - Guide de release (peut être supprimé)
- `REORGANIZE_STRUCTURE.md` - Guide de réorganisation (peut être supprimé)
- `reorganize.sh` - Script de réorganisation (peut être supprimé)
- `WIKI.md` - Documentation wiki (peut être gardé pour référence)

Ces fichiers ne sont pas nécessaires pour le fonctionnement de l'add-on.

