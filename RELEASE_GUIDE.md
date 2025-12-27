# Guide de Release - Version 0.2.0

## Étapes pour publier la version 0.2.0

### 1. Vérifier les fichiers modifiés

```bash
git status
```

### 2. Ajouter les fichiers modifiés

```bash
git add CHANGELOG.md config.yaml README.md WIKI.md
```

**Note:** Ne pas ajouter `COMMIT_MESSAGE.md` et `RELEASE_GUIDE.md` (fichiers temporaires)

### 3. Commit les changements

**Version courte:**
```bash
git commit -m "chore: bump version to 0.2.0 - update repository URLs and add wiki documentation"
```

**Version complète:**
```bash
git commit -m "chore: bump version to 0.2.0

- Updated all repository URLs from homeassistant-dozzle-addon to homeassistant-dozzle-agent
- Updated documentation links in config.yaml
- Updated README.md with correct repository references and badges
- Added comprehensive wiki documentation (WIKI.md)
  - Complete installation and usage guide
  - Troubleshooting section
  - FAQ section
  - Advanced configuration documentation"
```

### 4. Créer le tag de version

```bash
git tag -a v0.2.0 -m "Release version 0.2.0

- Updated repository URLs to homeassistant-dozzle-agent
- Added comprehensive wiki documentation
- Updated all documentation links"
```

### 5. Push le commit et le tag

**Option 1: Push séparé (recommandé)**
```bash
# Push le commit
git push origin main

# Push le tag
git push origin v0.2.0
```

**Option 2: Push en une fois**
```bash
# Push le commit et tous les tags
git push origin main --tags
```

**Option 3: Push uniquement le tag spécifique**
```bash
# Push le commit
git push origin main

# Push uniquement le tag v0.2.0
git push origin refs/tags/v0.2.0
```

## Vérification après le push

### Vérifier que le tag est bien créé sur GitHub

1. Aller sur: https://github.com/Erreur32/homeassistant-dozzle-agent/tags
2. Vérifier que le tag `v0.2.0` apparaît

### Créer une Release GitHub (optionnel mais recommandé)

1. Aller sur: https://github.com/Erreur32/homeassistant-dozzle-agent/releases/new
2. Sélectionner le tag `v0.2.0`
3. Titre: `v0.2.0`
4. Description:
```markdown
## Version 0.2.0

### Changed
- Updated all repository URLs to `homeassistant-dozzle-agent`
- Updated documentation links in config.yaml
- Updated README.md with correct repository references

### Added
- Comprehensive wiki documentation (WIKI.md)
- Complete installation and usage guide
- Troubleshooting section
- FAQ section
- Advanced configuration documentation
```

## Commandes complètes (copier-coller)

```bash
# 1. Vérifier l'état
git status

# 2. Ajouter les fichiers
git add CHANGELOG.md config.yaml README.md WIKI.md

# 3. Commit
git commit -m "chore: bump version to 0.2.0 - update repository URLs and add wiki documentation"

# 4. Créer le tag
git tag -a v0.2.0 -m "Release version 0.2.0"

# 5. Push commit et tag
git push origin main
git push origin v0.2.0
```

## Notes importantes

- ✅ Le tag doit être au format `v0.2.0` (avec le `v` devant)
- ✅ Home Assistant utilise les tags Git pour identifier les versions
- ✅ Le tag doit pointer vers le commit qui contient `config.yaml` avec `version: "0.2.0"`
- ✅ Après le push, Home Assistant pourra détecter la nouvelle version automatiquement

