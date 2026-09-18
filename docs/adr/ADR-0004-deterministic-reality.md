# ADR-0004 — Réalité déterministe, IA optionnelle

**Statut : Accepted**

## Contexte
Les LLM sont probabilistes et évoluent rapidement. Les lois du monde et les problèmes doivent rester cohérents, testables et pédagogiquement fiables.

## Décision
Séparer Reality, Pedagogy et AI Layers. La Reality Layer est déterministe. L'IA est optionnelle, remplaçable et n'est jamais l'autorité du monde.

## Conséquences
- les mécaniques fondamentales restent fonctionnelles sans LLM ;
- les tests peuvent reproduire les états critiques ;
- changer de fournisseur ou modèle IA ne nécessite pas de reconstruire le jeu ;
- un système déterministe est préféré lorsqu'il suffit.
