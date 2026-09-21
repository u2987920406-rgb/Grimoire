# Playtest Web E2E 001 — La Vallée oubliée

**Date : 2026-09-21**  
**Plateforme : navigateur mobile**  
**Statut : VALIDÉ HUMAINEMENT**

## Parcours validé

Le joueur a terminé l'aventure de bout en bout dans la version Web publiée :

- réparation de la charrette ;
- traversée du pont ;
- découverte du village ;
- réglage équilibré de la vanne ;
- réutilisation de la borne solaire III ;
- récupération du disque solaire ;
- insertion du disque dans le mécanisme des ruines ;
- ouverture des ruines ;
- exploration de la chambre finale ;
- réglage du répartiteur ancien ;
- activation du cœur de la vallée ;
- conclusion atteinte.

## Incidents détectés pendant le playtest

### Terrain / limites
Un écart entre le mesh du sol et sa collision rendait certaines zones visuellement accessibles mais physiquement absentes.

**Correction :** alignement mesh/collision + limites physiques du monde + test automatique de navigation.

### Pont
Le pont existait visuellement mais n'était pas réellement traversable.

**Correction :**
- rampes d'accès physiques ;
- traversée réelle du personnage testée automatiquement ;
- rivière bloquée hors du passage du pont pour que le pont ait une fonction réelle.

## Validation actuelle

- E2E logique automatique : PASS
- Navigation/collisions automatique : PASS
- Export Web : PASS
- Publication Web : PASS
- Playtest humain complet : PASS

## Décision

La Vallée oubliée possède désormais une boucle E2E jouable complète.

La prochaine phase doit prioriser la qualité d'expérience plutôt que l'ajout de nouvelles mécaniques :
- lisibilité spatiale ;
- direction artistique ;
- ambiance sonore ;
- transitions ;
- feedbacks ;
- rythme ;
- densité du décor ;
- suppression progressive de l'aspect graybox.

Aucune nouvelle mécanique structurante ne doit être ajoutée sans nécessité démontrée.
