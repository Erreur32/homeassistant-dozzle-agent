# Commandes Git pour la version 0.2.2

## Fichiers modifiés

- `dozzle-agent/config.yaml` : version mise à jour à 0.2.2
- `dozzle-agent/CHANGELOG.md` : section 0.2.2 ajoutée
- `README.md` : badge version mis à jour à v0.2.2
- `dozzle-agent/README.md` : logo SVG ajouté
- `dozzle-agent/dozzle.svg` : nouveau fichier

## Commandes Git à exécuter

### 1. Ajouter tous les changements

```bash
git add -A
```

### 2. Vérifier les changements

```bash
git status
```

Vous devriez voir :
- `dozzle-agent/config.yaml` (modifié)
- `dozzle-agent/CHANGELOG.md` (modifié)
- `README.md` (modifié)
- `dozzle-agent/README.md` (modifié)
- `dozzle-agent/dozzle.svg` (nouveau)

### 3. Commit avec message

```bash
git commit -m "chore: bump version to 0.2.2 - add SVG logo and branding

- Updated version to 0.2.2 in config.yaml
- Added Dozzle SVG logo to README files
- Added 'Dozzle Agent' title text next to logo
- Added Quick Start section with Home Assistant badge
- Improved visual branding with SVG logo
- Updated CHANGELOG.md with v0.2.2 changes"
```

### 4. Push vers GitHub

```bash
git push origin main
```

### 5. Créer le tag v0.2.2

```bash
git tag -a v0.2.2 -m "Release version 0.2.2

- Added Dozzle SVG logo to README files
- Added 'Dozzle Agent' title text next to logo
- Added Quick Start section with Home Assistant badge
- Improved visual branding with SVG logo
- Updated repository presentation"
```

### 6. Push le tag

```bash
git push origin v0.2.2
```

## Commandes complètes (copier-coller)

```bash
# 1. Ajouter tous les changements
git add -A

# 2. Commit
git commit -m "chore: bump version to 0.2.2 - add SVG logo and branding

- Updated version to 0.2.2 in config.yaml
- Added Dozzle SVG logo to README files
- Added 'Dozzle Agent' title text next to logo
- Added Quick Start section with Home Assistant badge
- Improved visual branding with SVG logo
- Updated CHANGELOG.md with v0.2.2 changes"

# 3. Push le commit
git push origin main

# 4. Créer le tag
git tag -a v0.2.2 -m "Release version 0.2.2

- Added Dozzle SVG logo to README files
- Added 'Dozzle Agent' title text next to logo
- Added Quick Start section with Home Assistant badge
- Improved visual branding with SVG logo"

# 5. Push le tag
git push origin v0.2.2
```

## Vérification après le push

1. Vérifier le tag sur GitHub : https://github.com/Erreur32/homeassistant-dozzle-agent/tags
2. Vérifier que la version 0.2.2 apparaît dans le repository
3. Optionnel : Créer une Release GitHub avec les notes du CHANGELOG

