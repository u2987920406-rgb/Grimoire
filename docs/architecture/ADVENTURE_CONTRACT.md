# Adventure Contract — brouillon normatif v0.2

Toute aventure doit être chargeable par l'Adventure Core sans modifier celui-ci pour ses besoins ordinaires.

Cette version v0.2 est dérivée du premier vertical slice de `La Vallée oubliée`. Elle reste volontairement minimale.

## Principe

**Adventure Core + Adventure Content = Playable Adventure**

Le Core fournit les capacités génériques.
L'aventure déclare ses scènes, objets, personnages, problèmes, dialogues et contenu spécifique.

Une aventure ne doit pas implémenter son propre système parallèle pour contourner le Core.

## AdventureDefinition

Champs conceptuels :
- `id`
- `schema_version`
- `content_version`
- `title_key`
- `age_target`
- `estimated_duration_minutes`
- `entry_scene`
- `ending_scene`
- `areas[]`
- `characters[]`
- `problems[]`
- `discoveries[]`
- `audio_profile`
- `ui_skin`

Les champs `knowledge[]` et autres systèmes pédagogiques avancés restent possibles mais ne sont pas obligatoires pour le premier slice.

## WorldObjectDefinition

Un objet de monde peut déclarer :
- `object_id`
- `scene`
- `initial_transform`
- `interaction_capabilities[]`
- `physical_properties`
- `initial_state`
- `tags[]`

Exemples de capacités v0.1 :
- `INSPECT`
- `TAKE`
- `DROP`
- `THROW`
- `PUSH`
- `PLACE`
- `TALK`

Les capacités sont des possibilités réelles, pas des boutons obligatoirement affichés.

## PhysicalProperties

Le contrat ne prétend pas simuler toute la matière.

Propriétés minimales possibles :
- `mass_class`
- `movable`
- `floatable`
- `breakable`
- `attached`
- `friction_profile`

Une propriété ne doit exister que si un comportement de jeu en dépend.

## CharacterDefinition

Champs conceptuels :
- `character_id`
- `scene`
- `initial_state`
- `dialogue_set`
- `reaction_rules[]`

Pour v0.1, les réactions peuvent être simples et déterministes.

## ProblemDefinition

- `problem_id`
- `problem_type: CLOSED | OPEN | TRADEOFF`
- `initial_state`
- `goal_conditions[]`
- `constraints[]`
- `observables[]`
- `known_solutions[]` — pour conception/tests, jamais liste blanche par défaut
- `consequences[]`
- `assistance_policy`

Les champs pédagogiques avancés (`knowledge_links[]`, `transfer_links[]`) restent compatibles avec la direction du projet mais peuvent attendre leur premier cas concret.

## GoalCondition

Une condition de réussite décrit un état observable du monde.

Exemples :
- `cargo_delivered == true`
- `player_reached_village == true`
- `wheel_retained == true`

Éviter :
- `used_branch == true`
- `selected_solution_b == true`

Le moteur évalue le résultat et les contraintes, pas la recette attendue.

## Object State

Les états doivent être explicites lorsqu'ils influencent la logique.

Exemples du slice :
- `wheel_attached`
- `wheel_retained`
- `cart_can_move`
- `apple_in_water`
- `apple_floating`
- `stone_inspected`

Un état n'est ajouté que s'il est utile au comportement, à un test ou à une future sauvegarde.

## ConsequenceDefinition

Une conséquence relie un changement d'état à une réponse du monde.

Forme conceptuelle :
- `trigger`
- `conditions[]`
- `effects[]`

Effets v0.1 possibles :
- jouer une animation ;
- jouer un son ;
- modifier un état ;
- détacher un objet ;
- déclencher une ligne de dialogue ;
- activer/désactiver une interaction ;
- signaler un problème comme résolu.

Le système peut commencer par de simples signaux Godot. Aucun moteur de règles générique n'est requis avant nécessité.

## InspectionDefinition

Pour les objets examinables :
- `inspection_id`
- `target_object_id`
- `focus_camera`
- `focus_text_key` optionnel
- `discovery_id` optionnel

L'inspection attire l'attention sans interpréter automatiquement l'indice.

## Dialogue Contract

Le dialogue v0.1 doit permettre :
- lignes courtes ;
- déclenchement contextuel ;
- variation selon l'état ;
- fermeture/reprise immédiate du jeu.

Le dialogue ne doit pas être requis pour exprimer une règle que le monde peut montrer directement.

## Adventure Runtime Events

Événements minimaux envisagés :
- `interaction_started`
- `interaction_completed`
- `object_state_changed`
- `problem_state_changed`
- `dialogue_requested`
- `inspection_started`
- `inspection_completed`

Les noms définitifs seront validés lors de l'implémentation GDScript.

## Isolation

Une aventure :
- ne dépend pas d'une autre aventure ;
- ne remplace pas un système générique du Core ;
- peut demander une extension du Core uniquement via décision d'architecture explicite ;
- doit déclarer ses dépendances de contenu et ses versions compatibles.

## Règle anti-surconception

Le contrat ne doit pas anticiper dix aventures fictives.

Toute nouvelle abstraction publique doit être justifiée par :
1. un cas concret dans une aventure ;
2. un besoin de réutilisation réel ou fortement démontré ;
3. un test possible.

## Statut v0.2

Ce contrat est suffisant pour commencer le bootstrap technique du vertical slice.

Il sera révisé après le premier prototype jouable, avant tout gel `v1`.
