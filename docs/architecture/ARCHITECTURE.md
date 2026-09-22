# Architecture — Foundation v0.1

## Décisions de base

- Moteur cible : Godot 4.x stable au moment du démarrage effectif de l'implémentation.
- Langage principal : GDScript typé.
- Architecture : Adventure Core partagé + Adventures modulaires.
- Contenu d'aventure : data-driven autant que raisonnablement possible.
- Présentation par aventure : 2D dynamique / 2.5D illustrée pour La Vallée oubliée ; le Core ne dépend pas d'un mode de rendu unique.
- Les mécaniques fondamentales fonctionnent sans LLM.

La version exacte du moteur doit être verrouillée dans le projet lors du bootstrap technique et enregistrée par ADR si elle diffère de la décision courante.

## Couches

### Adventure Core
Runtime, interaction, joueur, caméra, monde, objets, simulation, construction, inventaire, dialogues, connaissances, assistance, audio, sauvegarde, télémétrie locale éventuelle.

### UI
Design System partagé, Grimoire, HUD, inventaire, dialogue, journal, réglages.

### Adventures
Environnements, personnages, objets spécifiques, problèmes, dialogues, connaissances contextualisées, audio, cinématiques et configuration.

### Shared
Assets réellement réutilisés entre plusieurs aventures.

## Dépendances

Autorisé :
`Adventure -> Core`
`Adventure -> UI public API`
`Core -> composants Core`

Interdit :
`Core -> Adventure spécifique`
`Adventure A -> Adventure B`
`Adventure -> internals privés du Core`

## Architecture de décision

Reality Layer -> état déterministe et simulation.
Pedagogy Layer -> interprétation de progression, règles d'aide, liens de connaissance.
AI Layer -> service probabiliste optionnel et remplaçable.

L'AI Layer ne décide pas des vérités du Reality Layer.

## Structure cible

```
core/
ui/
adventures/
shared/
tests/
tools/
docs/
```

La structure détaillée sera créée avec le bootstrap Godot, sans dossiers vides artificiels dans Git.
