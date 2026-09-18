# ADR-0002 — Aventures modulaires

**Statut : Accepted**

## Contexte
Le projet doit rester fluide lorsque de nouveaux univers sont créés des mois ou années plus tard.

## Décision
Séparer un Adventure Core partagé des Adventures. Les aventures sont autonomes, isolées et principalement data-driven.

## Conséquences
- une nouvelle aventure réutilise interactions, UI, sauvegarde et systèmes génériques ;
- les aventures ne dépendent pas entre elles ;
- une mécanique générique nouvelle doit être évaluée comme extension du Core ;
- La Vallée oubliée sert aussi à éprouver le framework.
