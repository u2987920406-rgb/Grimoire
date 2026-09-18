# Stratégie de test

## Principe

Le code existant n'est pas une preuve de fonctionnement. Le comportement doit être exécuté et vérifié.

## Niveaux

### Unit
Logique pure, contrats, conditions de réussite, migrations de données.

### Integration
Interactions entre Core, UI, sauvegarde, runtime d'aventure et simulation.

### Adventure Contract
Chaque aventure doit valider son schéma, ses références, dépendances, scènes d'entrée/sortie et ressources obligatoires.

### Parcours
Pour chaque vertical slice, exécuter le parcours joueur correspondant de bout en bout.

### Playtest enfant
Observer le comportement réel plutôt que demander uniquement « tu aimes ? ».

Questions :
- comprend-il quoi faire sans documentation ?
- explore-t-il spontanément ?
- essaie-t-il plusieurs approches ?
- modifie-t-il son comportement après un échec ?
- cherche-t-il immédiatement un indice ?
- peut-il expliquer ce qu'il pense se passer ?
- réutilise-t-il une découverte antérieure ?
- s'amuse-t-il réellement ?
- veut-il continuer ou revenir jouer ?

## Prototype initial

Hypothèse :
« Un enfant d'environ 8 ans prend-il plaisir à résoudre librement un problème dans un environnement cohérent, en expérimentant plusieurs solutions, sans qu'un système lui fournisse le raisonnement ? »

Le premier prototype doit être suffisamment petit pour invalider rapidement cette hypothèse si nécessaire.
