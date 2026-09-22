# ADR-0006 — Pivot de La Vallée oubliée vers une 2D dynamique illustrée

**Statut : Accepté**  
**Date : 2026-09-22**

## Contexte

La boucle E2E de La Vallée oubliée a été validée en 3D graybox sur mobile Web.

La validation a montré que la logique de jeu fonctionne, mais que la direction artistique cible demanderait un coût de production 3D trop élevé pour conserver une qualité cohérente sur plusieurs aventures.

La charte visuelle Grimoire repose davantage sur :
- des compositions illustrées fortes ;
- des environnements détaillés et lisibles ;
- des personnages expressifs ;
- une sensation de livre d'aventure vivant.

## Décision

La Vallée oubliée adopte une présentation **2D dynamique / 2.5D illustrée**.

Le moteur reste **Godot 4.7.2**.

Le jeu conserve :
- les mêmes objectifs cognitifs ;
- les mêmes énigmes validées ;
- la même progression E2E ;
- les mêmes états de monde déterministes.

Le rendu change :
- tableaux illustrés ;
- personnage séparé du décor ;
- déplacement tactile/clic sur zones marchables ;
- hotspots contextuels ;
- profondeur simulée par échelle/parallaxe ;
- transitions entre scènes.

## Non-décision

La version 3D validée n'est pas supprimée. Elle reste une référence de gameplay et de non-régression jusqu'à ce que la nouvelle version 2D atteigne la même couverture E2E.

## Raison principale

Le pivot doit permettre au jeu réel de se rapprocher fortement de la charte artistique sans dépendre d'une chaîne de production 3D lourde.

## Garde-fous

- Pas de hotspot sans conséquence réelle.
- Pas de décor purement illustratif qui contredit les interactions.
- Les puzzles restent fondés sur la logique du monde.
- La lisibilité enfant prime sur la densité graphique.
- La version 2D doit retrouver le parcours E2E validé avant abandon définitif du runtime 3D.
