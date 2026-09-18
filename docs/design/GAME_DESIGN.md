# Principes de Game Design

## Game first

Le joueur doit pouvoir raconter une aventure, pas une leçon.

Exemple de résultat recherché : « J'ai remis le moulin en marche, mais j'ai inondé le jardin ! »

## Familles de problèmes

### CLOSED
Problème fermé : une vérité ou condition précise doit être découverte. Encourage observation et déduction.

### OPEN
Problème ouvert : plusieurs solutions peuvent satisfaire l'objectif sous les lois du monde. Encourage créativité, expérimentation et débrouillardise.

### TRADEOFF
Problème de compromis : aucune solution parfaite ; ressources, conséquences ou intérêts entrent en tension. Encourage jugement et décision.

Une aventure doit varier les rythmes et ne pas réduire l'expérience à une seule famille.

## Évaluation d'un problème

Ne pas coder « la recette gagnante » lorsque l'état du monde suffit.

Mauvais :
`used_bridge == true`

Préféré :
`player_on_other_side && crate_on_other_side && !crate_destroyed`

Les solutions connues servent aux tests et au design, pas nécessairement de liste blanche.

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

« Un enfant d'environ 8 ans prend-il plaisir à résoudre librement un problème dans un environnement cohérent, en expérimentant plusieurs solutions, sans qu'un système lui fournisse le raisonnement ? »
