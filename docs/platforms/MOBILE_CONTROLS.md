# Contrôles mobiles — Grimoire

**Statut : prototype v0.1**

Grimoire doit rester jouable sur PC et écran tactile avec la même logique de gameplay.

## Mobile

Orientation cible du prototype : **paysage**.

Contrôles du graybox :
- joystick virtuel à gauche : déplacement ;
- bouton **Interagir** à droite ;
- bouton **Poser** lorsqu'un objet est tenu ;
- bouton **Lancer** lorsqu'un objet est tenu ;
- bouton **Retour** pour fermer une inspection ou un dialogue.

## PC

Le clavier reste disponible :
- WASD : déplacement ;
- E : interagir ;
- Q : poser ;
- F : lancer ;
- Échap : fermer inspection/dialogue.

## Règle d'architecture

Les mécaniques ne doivent pas dépendre directement d'un périphérique. Le Player Controller reçoit une intention de mouvement et des demandes d'action, qu'elles viennent du clavier, d'une manette ou du tactile.

Les boutons tactiles sont une couche d'entrée, pas une implémentation séparée du gameplay.

## Critères mobiles

- cibles tactiles suffisamment grandes ;
- aucune information importante uniquement au survol ;
- UI lisible sur téléphone ;
- commandes accessibles sans changer fortement la prise en main ;
- aucun geste complexe requis pour les interactions de base ;
- le jeu reste jouable au clavier/manette.

La disposition devra être testée sur appareil réel avant gel.
