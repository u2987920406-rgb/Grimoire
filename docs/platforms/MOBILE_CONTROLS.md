# Contrôles mobiles — Grimoire

**Statut : prototype v0.2**

Grimoire doit rester jouable sur PC et écran tactile avec la même logique de gameplay.

## Mobile

Orientation cible du prototype : **paysage**.

Contrôles du graybox :
- joystick virtuel **gauche** : déplacement ;
- joystick virtuel **droit** : orientation de la caméra ;
- bouton **Interagir** à droite, au-dessus du stick caméra ;
- bouton **Poser** lorsqu'un objet est tenu ;
- bouton **Lancer** lorsqu'un objet est tenu ;
- bouton **Retour** pour fermer une inspection ou un dialogue.

## Principe de caméra

Le déplacement du personnage ne doit pas entraîner automatiquement la vue.

Le stick gauche contrôle l'intention de déplacement par rapport à l'orientation actuelle de la caméra.

Le stick droit contrôle l'orbite de caméra :
- rotation horizontale libre ;
- inclinaison verticale limitée ;
- vitesse modérée pour éviter le mal des transports et les mouvements brusques.

Ce comportement doit rester proche des conventions d'une manette moderne.

## PC

Le clavier reste disponible :
- WASD : déplacement ;
- E : interagir ;
- Q : poser ;
- F : lancer ;
- Échap : fermer inspection/dialogue.

Le contrôle caméra PC sera ajouté/ajusté séparément sans modifier la logique mobile.

## Règle d'architecture

Les mécaniques ne doivent pas dépendre directement d'un périphérique. Le Player Controller reçoit une intention de mouvement, une intention de caméra et des demandes d'action.

Les boutons et joysticks tactiles sont une couche d'entrée, pas une implémentation séparée du gameplay.

## Critères mobiles

- deux zones tactiles distinctes déplacement/caméra ;
- cibles tactiles suffisamment grandes ;
- aucune information importante uniquement au survol ;
- UI lisible sur téléphone ;
- commandes accessibles sans changer fortement la prise en main ;
- aucun geste complexe requis pour les interactions de base ;
- le jeu reste jouable au clavier/manette ;
- la caméra ne doit pas tourner simplement parce que le personnage change de direction.

La disposition devra être testée sur appareil réel avant gel.
