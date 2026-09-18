# AGENTS.md — Grimoire

## Mission

Grimoire est une plateforme de jeux d'aventure destinée initialement aux enfants d'environ 8 ans. Elle contient des aventures autonomes de 45 à 90 minutes accessibles depuis un grimoire magique.

Le produit doit développer la capacité du joueur à observer, questionner, analyser, imaginer, choisir, agir, constater, corriger, comprendre et réutiliser ses découvertes.

## Source de vérité

Avant toute modification importante, lire :
1. `docs/constitution/CONSTITUTION.md`
2. `docs/constitution/VISION.md`
3. `docs/design/GAME_DESIGN.md`
4. `docs/architecture/ARCHITECTURE.md`
5. `docs/architecture/CONVENTIONS.md`

Pour une aventure, lire également sa documentation locale.

Ordre d'autorité :
**Constitution > ADR acceptés > Architecture et contrats > Spécification d'aventure > Implémentation.**

En cas de conflit ou d'ambiguïté, ne pas contourner la règle : documenter le conflit et demander une décision.

## Règles absolues

- Le plaisir de jeu passe avant la démonstration pédagogique.
- Ne jamais retirer au joueur une étape intellectuelle importante.
- Préférer l'expérimentation à l'explication lorsqu'une découverte raisonnable par l'action est possible.
- L'échec doit produire une information exploitable, une conséquence compréhensible ou un moment ludique.
- Le monde obéit à des règles cohérentes.
- La liberté existe à l'intérieur des contraintes du monde.
- Une solution émergente valide ne doit pas être rejetée uniquement parce qu'elle n'était pas prévue.
- Évaluer l'état du monde et les contraintes de réussite, pas la recette attendue.
- Les connaissances servent l'action et doivent, lorsque pertinent, pouvoir être réutilisées dans un autre contexte.
- Une aventure ne réimplémente pas un système générique du Core.
- Une aventure ne dépend jamais d'une autre aventure.
- Une aventure ne modifie jamais silencieusement le Core.
- L'IA n'est jamais l'autorité sur les lois ou vérités déterministes du monde.
- Ne pas utiliser d'IA lorsqu'un système déterministe fait mieux le travail.
- Le jeu doit rester jouable sans LLM pour ses mécaniques fondamentales.

## Méthode de travail

Avant toute modification importante :
1. Inspecter le projet et l'existant.
2. Lire les documents et ADR concernés.
3. Identifier les contraintes et critères d'acceptation.
4. Établir un plan minimal et vérifiable.
5. Modifier par petites étapes.
6. Exécuter le projet et les tests concernés.
7. Diagnostiquer et corriger les régressions avant de continuer.
8. Vérifier les critères d'acceptation.
9. Mettre à jour la documentation lorsque la réalité du projet change.

Ne jamais supposer qu'une fonctionnalité fonctionne parce que son code existe.
Ne pas présenter une simulation, un mock ou un bouton factice comme fonctionnel.
Ne pas laisser de TODO important silencieux.
Préserver les fonctionnalités existantes sauf décision explicite contraire.

## Architecture

Séparation obligatoire : **Adventure Core != Adventures**.

Le Core fournit les systèmes génériques : runtime d'aventure, interactions, joueur, caméra, monde, objets, physique simplifiée, construction, inventaire, dialogues, connaissances, assistance, audio, sauvegarde et UI partagée.

Les Adventures fournissent principalement : contenu, configuration, environnements, personnages, objets spécifiques, problèmes, dialogues, connaissances contextualisées, audio et cinématiques.

Les aventures doivent être autant que raisonnablement possible pilotées par les données et respecter les contrats publics du Core.

## UX/UI

Le décor et le skin peuvent changer entre aventures. Le langage d'interaction, la hiérarchie, les comportements des contrôles et les composants fondamentaux restent cohérents.

Ne pas créer un nouveau comportement de bouton, inventaire, dialogue, pause ou interaction uniquement pour une aventure sans décision d'architecture.

## IA

Séparer :
1. Reality Layer — déterministe.
2. Pedagogy Layer — règles et état observables.
3. AI Layer — probabiliste et remplaçable.

L'AI Layer ne modifie jamais directement les vérités fondamentales ou la physique du monde.

## Décisions d'architecture

Toute modification significative concernant la Constitution, un contrat public, l'Adventure Core, le Design System, le format de sauvegarde, les frontières IA ou la compatibilité inter-aventures exige un ADR.

Une contrainte technique ne doit jamais modifier silencieusement une décision pédagogique ou de game design.

## Definition of Done

Une tâche n'est terminée que si :
- le comportement existe réellement ;
- les tests pertinents passent ;
- le parcours concerné a été exécuté lorsque possible ;
- les régressions connues ont été traitées ou explicitement documentées ;
- les critères d'acceptation sont satisfaits ;
- la documentation correspond à l'implémentation ;
- les problèmes restants sont explicitement signalés.
