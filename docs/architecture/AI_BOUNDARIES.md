# Frontières de l'IA

## Principe

Grimoire n'est pas un cours d'utilisation de l'IA. L'IA est un outil éventuel du système, jamais la source de vérité du monde ni le substitut au raisonnement du joueur.

## Interdit

Un LLM ne décide pas :
- si une construction physique tient ;
- si une propriété matérielle est vraie ;
- de la solution d'un problème fermé ;
- d'un état critique de progression ;
- de la réussite fondamentale d'un objectif ;
- d'une conséquence déterministe essentielle.

## Usages potentiels à tester

- interpréter une intention difficile à exprimer par UI classique ;
- adapter subtilement une aide ;
- produire certains dialogues secondaires contrôlés ;
- résumer le parcours intellectuel pour le système ;
- proposer une formulation contextuelle sans modifier la vérité du jeu.

Aucun de ces usages n'est acquis avant prototype.

## Interface

Le système d'assistance doit pouvoir fonctionner derrière une abstraction de type `AssistanceProvider`.

Implémentations possibles :
- `RuleBasedAssistance`
- `LocalAIAssistance`
- `CloudAIAssistance`

Le reste du jeu ne doit pas dépendre d'un fournisseur ou modèle particulier.

## Aide

L'aide ne se déclenche pas sur un simple compteur d'échecs. Le système distingue autant que possible expérimentation active, répétition, blocage et exploration volontaire.

Lorsqu'une question peut être résolue naturellement par expérience dans le monde, privilégier l'expérience.
