# Commandes Git pour ajouter tous les fichiers

## Situation actuelle

Git voit :
- ✅ Fichiers supprimés de la racine (normal, ils ont été déplacés)
- ✅ README.md modifié
- ⚠️ `repository.json` et `dozzle-agent/` ne sont pas encore détectés comme nouveaux fichiers

## Commandes à exécuter dans l'ordre

### Option 1 : Ajouter tout en une fois (recommandé)

```bash
# Ajouter tous les nouveaux fichiers et les suppressions
git add -A

# Vérifier que tout est bien ajouté
git status
```

### Option 2 : Ajouter étape par étape

```bash
# 1. Ajouter le repository.json
git add repository.json

# 2. Ajouter tout le dossier dozzle-agent/
git add dozzle-agent/

# 3. Ajouter les fichiers supprimés (déplacés)
git add -u

# 4. Ajouter les fichiers de documentation (optionnel)
git add GIT_COMMIT_STEPS.md RELEASE_GUIDE.md REORGANIZE_STRUCTURE.md reorganize.sh

# Vérifier
git status
```

## Après git add, vous devriez voir :

```
Changes to be committed:
  new file:   repository.json
  new file:   dozzle-agent/... (tous les fichiers)
  deleted:    CHANGELOG.md (depuis la racine)
  deleted:    Dockerfile (depuis la racine)
  ...
  modified:   README.md
```

## Ensuite, commit :

```bash
git commit -m "chore: reorganize repository structure for Home Assistant

- Created repository.json at root for Home Assistant repository recognition
- Moved all add-on files to dozzle-agent/ directory
- Updated README.md to reflect repository structure
- Repository now follows Home Assistant add-on repository structure"
```

