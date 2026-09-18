# Adventure Contract — brouillon normatif v0.1

Toute aventure doit être chargeable par l'Adventure Core sans modifier celui-ci pour ses besoins ordinaires.

## AdventureDefinition

Champs conceptuels initiaux :
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
- `knowledge[]`
- `discoveries[]`
- `audio_profile`
- `ui_skin`

Le schéma concret sera validé pendant le prototype avant gel v1.

## ProblemDefinition

- `problem_id`
- `problem_type: CLOSED | OPEN | TRADEOFF`
- `initial_state`
- `goal_conditions[]`
- `constraints[]`
- `observables[]`
- `available_actions[]`
- `known_solutions[]` — pour conception/tests, pas liste blanche par défaut
- `consequences[]`
- `knowledge_links[]`
- `transfer_links[]`
- `assistance_policy`

## Règle de réussite

Le moteur privilégie les conditions d'état et contraintes observables plutôt que la vérification d'une séquence d'actions attendue.

## Isolation

Une aventure :
- ne dépend pas d'une autre aventure ;
- ne remplace pas un système générique du Core ;
- peut demander une extension du Core uniquement via décision d'architecture explicite ;
- doit déclarer ses dépendances de contenu et ses versions compatibles.
