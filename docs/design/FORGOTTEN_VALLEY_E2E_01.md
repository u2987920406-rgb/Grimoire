# La Vallée oubliée — E2E 0.1

**Statut : implémentation graybox complète en cours de validation Web.**

## Parcours jouable visé

1. arrivée dans la vallée ;
2. manipulation libre de la pomme ;
3. réparation de la charrette ;
4. traversée du pont et entrée au village ;
5. observation du moulin, des cultures et de la vanne ;
6. expérimentation sur le partage de l'eau ;
7. équilibre du réseau : moulin alimenté sans assécher les cultures ;
8. enquête à l'atelier et réutilisation de la borne solaire III ;
9. découverte du disque solaire ;
10. montée vers les ruines ;
11. insertion du disque dans le mécanisme ;
12. ouverture physique de la porte ;
13. accès au cœur de la vallée ;
14. conclusion E2E.

## Problème systémique de l'eau

La vanne possède trois états observables :
- priorité cultures : cultures alimentées, moulin arrêté ;
- partage équilibré : cultures alimentées et moulin fonctionnel ;
- priorité moulin : moulin fonctionnel, cultures privées d'eau.

La progression vers les ruines ne doit être possible qu'après le partage équilibré.

Le joueur reçoit l'information principalement par :
- le mouvement ou l'arrêt de la roue du moulin ;
- l'état du fossé des cultures ;
- les réactions d'un habitant ;
- le vieux croquis de l'atelier.

Aucun écran ne déclare « bonne réponse ».

## Enquête solaire

La borne III peut être observée avant que son utilité soit connue.

Après rétablissement équilibré du réseau, le fonctionnement du moulin provoque une vibration qui libère un disque solaire caché dans la borne III.

Le croquis de l'atelier indique :
> « Quand les deux canaux vivent, la troisième borne du soleil répond. »

Le joueur doit relier cette information à un élément déjà rencontré.

## Ruines

Le disque solaire correspond visuellement à la cavité du mécanisme.

L'insertion :
- consomme réellement l'objet porté ;
- ouvre réellement la porte ;
- désactive réellement sa collision ;
- donne accès à la zone finale.

## Conclusion

Le cœur de la vallée révèle que le moulin, les canaux et les bornes appartenaient à un ancien réseau commun.

La révélation finale doit reformuler l'aventure par le monde, pas par un score :
**« La vallée n'était pas cassée : ses liens avaient été oubliés. »**

## Critères d'acceptation E2E 0.1

Le build est accepté uniquement si :
- le parcours départ → fin peut être terminé sans recharger ;
- aucune étape critique ne dépend d'un dialogue obligatoire caché ;
- la charrette conserve la physique déjà validée ;
- le moulin réagit à l'état réel de l'eau ;
- les cultures réagissent à l'état réel de l'eau ;
- la solution équilibrée est déduite par conséquences ;
- la borne III est réutilisée après avoir pu être vue plus tôt ;
- le disque solaire est un véritable objet manipulable ;
- la porte des ruines perd réellement sa collision ;
- le joueur peut physiquement atteindre la zone finale ;
- chaque action contextuelle visible produit un effet réel ;
- le build Web fonctionne sur mobile tactile.

## Hors périmètre de E2E 0.1

Cette version ne cherche pas encore à finaliser :
- direction artistique ;
- modèles 3D définitifs ;
- animation de personnages ;
- musique ;
- doublage ;
- sauvegarde complète ;
- Grimoire méta-interface final ;
- localisation EN ;
- polish des transitions.

Ces éléments viennent après validation du parcours complet.
