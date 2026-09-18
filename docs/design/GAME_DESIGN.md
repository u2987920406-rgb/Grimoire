# Principes de Game Design

## Game first

Le joueur doit pouvoir raconter une aventure, pas une leçon.

Exemple de résultat recherché : « J'ai remis le moulin en marche, mais j'ai inondé le jardin ! »

## Réalisme de raisonnement

Grimoire ne récompense pas une idée uniquement parce qu'elle est originale.

Une solution doit survivre aux contraintes pertinentes :
- physiques ;
- scientifiques ;
- matérielles ;
- humaines ;
- contextuelles.

**Contraintes réelles + connaissance + créativité = solution.**

Le modèle n'exige pas un réalisme encyclopédique. Il exige une causalité suffisamment fidèle, stable et compréhensible pour que l'enfant puisse raisonner et transférer ce qu'il apprend.

## Familles de problèmes

### CLOSED
Problème fermé : une vérité ou condition précise doit être découverte. Encourage observation et déduction. Il peut n'avoir qu'une seule résultante valide.

### OPEN
Problème ouvert : plusieurs solutions plausibles peuvent satisfaire l'objectif sous les lois du monde. Encourage créativité, expérimentation et débrouillardise.

### TRADEOFF
Problème de compromis : aucune solution parfaite ; ressources, conséquences ou intérêts entrent en tension. Encourage jugement et décision.

Une aventure doit varier les rythmes et ne pas réduire l'expérience à une seule famille.

## Nombre de solutions

Ne pas imposer artificiellement trois solutions.

Pour un problème ouvert, viser généralement **1 à 3 familles de solutions intentionnellement conçues et testées**, uniquement lorsqu'elles sont rationnelles.

Trois familles utiles lorsque le contexte les permet :
- **improviser** : solution temporaire ou moins robuste ;
- **réparer/comprendre** : solution durable fondée sur une meilleure compréhension ;
- **contourner/repenser** : atteindre le véritable objectif sans résoudre nécessairement le problème apparent.

Ces catégories sont des outils de design, jamais des options affichées au joueur.

Une solution émergente supplémentaire peut fonctionner si les systèmes du monde la rendent réellement valide. Le moteur n'a pas à anticiper toutes les idées possibles.

## Problème apparent et objectif réel

Distinguer le mécanisme en panne du besoin.

Exemple : une roue de charrette tombe, mais l'objectif réel peut être d'amener une cargaison au village. Réparer la roue est alors un moyen, pas nécessairement l'objectif.

## Évaluation d'un problème

Ne pas coder « la recette gagnante » lorsque l'état du monde suffit.

Mauvais :
`used_bridge == true`

Préféré :
`player_on_other_side && crate_on_other_side && !crate_destroyed`

Les solutions connues servent aux tests et au design, pas nécessairement de liste blanche.

## Conséquences humaines

Une action physiquement possible n'est pas automatiquement socialement acceptable.

Prendre une planche dans une propriété, endommager un objet ou mettre un personnage en danger doit susciter des réactions cohérentes lorsque le contexte le justifie.

La cohérence sociale ne doit pas devenir un système moral artificiel ; elle doit découler des personnes et de la situation.

## Frustration productive

Le nombre d'échecs seul ne déclenche pas automatiquement une aide :
- nouvelles tentatives différentes : laisser explorer ;
- répétition identique : possible incompréhension d'une règle ;
- immobilité prolongée : possible blocage ;
- exploration ailleurs : comportement valide.

L'aide doit préserver la propriété du raisonnement.

## Connaissance

Boucle privilégiée :
**problème -> curiosité -> découverte/connaissance -> application -> conséquence -> réutilisation**

Les propriétés du monde sont montrées par comportement autant que possible : flotter, rouiller, basculer, casser, chauffer, conduire, brûler, etc.

## Liberté légère

Des moments sans objectif strict peuvent permettre de construire, manipuler ou jouer avec les systèmes. La cohérence du monde demeure.

## Première hypothèse MVP

« Un enfant d'environ 8 ans prend-il plaisir à résoudre librement un problème dans un environnement cohérent, en expérimentant plusieurs solutions plausibles, sans qu'un système lui fournisse le raisonnement ? »
