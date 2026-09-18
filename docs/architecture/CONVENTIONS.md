# Conventions du projet

## Langue

- Documentation produit et game design : français.
- Identifiants techniques, code, chemins, API et noms de ressources : anglais.
- Texte visible par le joueur : localisable ; français première langue de contenu.
- Ne jamais mélanger français et anglais dans un même vocabulaire technique.

## Godot / GDScript

- dossiers et fichiers : `snake_case`
- scripts : `snake_case.gd`
- classes et Nodes nommés : `PascalCase`
- fonctions et variables : `snake_case`
- signaux : `snake_case`
- constantes : `CONSTANT_CASE`
- enums : `PascalCase`
- valeurs d'enum : `CONSTANT_CASE`

Le code GDScript est typé lorsque raisonnable. Éviter les abstractions sans usage démontré.

## Vocabulaire canonique

Les termes suivants ont un sens stable :
- Adventure
- World
- Area
- Problem
- Objective
- Interaction
- WorldObject
- Property
- Action
- Consequence
- Discovery
- Knowledge
- Hint
- Character
- Dialogue
- Construction
- Experiment

Ne pas créer des synonymes techniques concurrents sans nécessité.

## Git

Branches de travail :
- `feature/...`
- `fix/...`
- `content/...`
- `refactor/...`
- `docs/...`

Commits :
- `feat:`
- `fix:`
- `content:`
- `refactor:`
- `test:`
- `docs:`
- `build:`

Les changements importants doivent rester petits, lisibles et vérifiables.

## Versions de contrat

Prévoir dès l'implémentation :
- `core_api_version`
- `adventure_schema_version`
- `save_schema_version`

Toute rupture de compatibilité doit être explicite et documentée.
