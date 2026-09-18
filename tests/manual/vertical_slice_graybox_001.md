# Test manuel — Vertical Slice Graybox 001

**Cible : Godot 4.7.2-stable**  
**Scène :** `res://adventures/forgotten_valley/scenes/bootstrap.tscn`

## Objectif

Valider que le premier graybox fonctionne réellement avant d'ajouter de nouvelles mécaniques.

## Parcours

1. Ouvrir le projet dans Godot 4.7.2-stable.
2. Lancer le projet.
3. Vérifier qu'aucune erreur de parsing n'apparaît.
4. Déplacer le personnage avec WASD.
5. Approcher la pomme.
6. Vérifier l'apparition du prompt `E Prendre pomme`.
7. Prendre la pomme.
8. Vérifier `Q Poser` et `F Lancer`.
9. Poser la pomme.
10. La reprendre puis la lancer.
11. Déposer/lancer la pomme dans la zone d'eau.
12. Vérifier qu'elle ralentit, flotte et dérive latéralement au lieu de couler normalement.
13. Parler au propriétaire de la charrette.
14. Vérifier que son message apparaît et peut être fermé.
15. Prendre la roue.
16. Approcher la charrette.
17. Vérifier que le prompt devient `Placer la roue`.
18. Placer la roue.
19. Vérifier le message confirmant le placement.
20. Interagir à nouveau avec la charrette.
21. Vérifier le `CLONK`, le détachement réel de la roue et son mouvement physique.
22. Approcher la borne ancienne.
23. Vérifier `Examiner`.
24. Ouvrir l'inspection.
25. Vérifier que `☀ III` est lisible et que le déplacement du joueur est bloqué.
26. Fermer avec E ou Échap.
27. Vérifier que le contrôle revient sans rupture.

## Critères d'échec

Le test échoue notamment si :
- le projet ne parse pas ;
- une interaction ne produit aucun effet ;
- un objet tenu disparaît ou reste bloqué ;
- la roue ne peut pas être replacée ;
- la roue ne se détache pas réellement ;
- la pomme traverse ou ignore l'eau ;
- le joueur reste bloqué après inspection ;
- le prompt affiche une action incorrecte ;
- une erreur console apparaît pendant le parcours.

## Retour attendu après premier test réel

Documenter :
- erreurs console exactes ;
- comportements inattendus ;
- sensation du déplacement ;
- facilité de compréhension des interactions ;
- lisibilité de la caméra ;
- caractère amusant ou non de la manipulation.

Aucune nouvelle fonctionnalité ne doit être ajoutée avant correction des erreurs bloquantes observées dans ce parcours.
