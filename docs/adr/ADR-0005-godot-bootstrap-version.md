# ADR-0005 — Version Godot du bootstrap

**Statut : Accepted**  
**Date : 18 septembre 2026**

## Contexte

Le bootstrap technique de Grimoire doit verrouiller une version stable de Godot afin que les tests, scènes et comportements du premier vertical slice soient reproductibles.

Au 18 septembre 2026, la branche stable actuelle est Godot **4.7.2-stable**. Godot 4.8 est encore en développement.

## Décision

Le premier bootstrap de Grimoire utilise :

- **Godot 4.7.2-stable**
- **GDScript typé**
- moteur standard, pas .NET/C# pour le prototype initial

## Pourquoi

- version stable et maintenue ;
- corrections de maintenance plus récentes que 4.7.1 ;
- évite d'introduire les risques d'une branche 4.8 encore en développement ;
- cohérent avec la décision Foundation : Godot 4.x stable au démarrage effectif.

## Alternatives

### Godot 4.8 dev
Rejeté pour le bootstrap : version de développement, inutile pour notre besoin immédiat.

### Godot 4.7.1
Valide mais remplacé par 4.7.2 stable avant le bootstrap.

### C#
Non retenu à ce stade : complexité et dépendances supplémentaires sans besoin démontré.

## Conséquences

Le projet doit rester ouvrable et testable sous Godot 4.7.2-stable.

Une montée de version ultérieure est possible après sauvegarde, tests et décision explicite si elle présente un bénéfice concret.
