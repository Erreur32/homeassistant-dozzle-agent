# Réorganisation de la structure du repository

## Problème

Home Assistant nécessite que les add-ons soient dans des sous-dossiers. Actuellement, tous les fichiers sont à la racine du repository.

## Structure actuelle (incorrecte)

```
homeassistant-dozzle-agent/
├── config.yaml
├── Dockerfile
├── run.sh
├── translations/
└── ...
```

## Structure requise (correcte)

```
homeassistant-dozzle-agent/
├── repository.json          ← NOUVEAU (déjà créé)
└── dozzle-agent/            ← NOUVEAU DOSSIER
    ├── config.yaml
    ├── Dockerfile
    ├── run.sh
    ├── translations/
    │   ├── en.json
    │   └── fr.json
    ├── icon.png
    ├── logo.png
    ├── apple-touch-icon.png
    ├── CHANGELOG.md
    └── README.md
```

## Solution : Script de réorganisation

Un script `reorganize.sh` a été créé pour automatiser cette réorganisation.

## Étapes manuelles (si vous préférez)

1. Créer le dossier `dozzle-agent/`
2. Déplacer tous les fichiers de l'add-on dans ce dossier (sauf `repository.json`)
3. Commit et push les changements

## Fichiers à déplacer dans `dozzle-agent/`

- config.yaml
- Dockerfile
- run.sh
- translations/ (dossier entier)
- icon.png
- logo.png
- apple-touch-icon.png
- CHANGELOG.md
- README.md
- requirements.txt (si présent)
- update_dozzle_version.sh

## Fichiers à garder à la racine

- repository.json (NOUVEAU - doit rester à la racine)
- README.md (peut rester à la racine comme README principal du repository)
- .gitignore
- Fichiers de documentation (WIKI.md, RELEASE_GUIDE.md, etc.)

