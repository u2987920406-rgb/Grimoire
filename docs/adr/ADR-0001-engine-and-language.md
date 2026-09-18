# ADR-0001 — Moteur et langage

**Statut : Accepted**

## Contexte
Grimoire nécessite une 3D stylisée, une UI riche, des scènes modulaires, du prototypage rapide et une architecture contrôlable sans viser le photoréalisme.

## Décision
Utiliser Godot 4.x stable et GDScript typé comme langage principal.

La version exacte sera verrouillée au bootstrap technique.

## Conséquences
- faible complexité d'outillage initiale ;
- intégration directe avec le modèle de scènes Godot ;
- C++/GDExtension reste possible uniquement si le profiling démontre un besoin réel ;
- éviter le mélange de langages sans justification.
