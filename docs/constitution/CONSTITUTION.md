# Constitution de Grimoire

**Statut : normative — Foundation v0.1**

Cette Constitution protège l'intention du projet contre les dérives de conception et les simplifications techniques silencieuses.

## Mission

Créer une véritable aventure qui développe progressivement chez l'enfant la débrouillardise, le raisonnement, l'observation, l'analyse, l'imagination, la créativité, le jugement et l'esprit critique, en lui permettant d'expérimenter dans un monde cohérent dont les connaissances acquises peuvent être réutilisées dans de nouvelles situations et, autant que possible, transférées au monde réel.

## Invariants

### JEU-01 — Jeu avant pédagogie
L'enfant doit vouloir jouer indépendamment de l'objectif éducatif. Une mécanique instructive mais ennuyeuse doit être repensée.

### COG-01 — Propriété du raisonnement
Le joueur conserve les étapes intellectuelles importantes. Aucun système, personnage ou IA ne doit systématiquement raisonner à sa place.

### EXP-01 — Expérimenter avant d'expliquer
Lorsqu'une propriété peut raisonnablement être découverte par l'action, le monde doit permettre de l'expérimenter avant de fournir l'explication.

### MONDE-01 — Liberté sous contraintes
Le monde possède des lois cohérentes. La créativité consiste à inventer une réponse à ces contraintes, pas à les supprimer.

### CREA-01 — Solutions émergentes
Une solution originale qui satisfait réellement l'objectif et les contraintes doit pouvoir réussir même si les designers ne l'avaient pas anticipée.

### ECHEC-01 — Échec informatif
L'échec doit produire de l'information, une conséquence intelligible ou une expérience ludique. Éviter « mauvaise réponse, recommence ».

### SAVOIR-01 — Connaissance en action
La culture générale et les connaissances apparaissent parce qu'elles permettent de comprendre ou d'agir dans l'aventure, pas comme un cours détaché.

### TRANSFERT-01 — Réutilisation
Les concepts importants doivent pouvoir réapparaître dans des contextes différents afin d'encourager le transfert.

### IA-01 — L'IA n'est pas l'autorité du monde
Les vérités fondamentales, la physique, les solutions déterministes et les états critiques ne dépendent pas d'une génération probabiliste.

### IA-02 — Déterministe avant probabiliste
Si une mécanique peut être réalisée de façon plus fiable, prévisible et contrôlable sans LLM, elle doit l'être.

### UX-01 — Cohérence inter-aventures
Changer d'univers ne doit pas obliger l'enfant à réapprendre le jeu. Les skins peuvent changer ; le langage d'interaction reste cohérent.

### ARCH-01 — Core et contenu séparés
Les systèmes génériques appartiennent à l'Adventure Core. Une aventure apporte principalement du contenu et de la configuration.

## Boucle cognitive de référence

**Observer -> Questionner -> Analyser -> Imaginer -> Choisir -> Agir -> Constater -> Corriger -> Comprendre -> Réutiliser**

Cette boucle est un outil de design. Elle ne doit pas devenir une procédure scolaire affichée au joueur.

## Test constitutionnel

Avant une mécanique importante, demander :
- Quel comportement voulons-nous encourager ?
- Quelle étape cognitive reste au joueur ?
- Le monde peut-il répondre par ses conséquences plutôt qu'un assistant ?
- Plusieurs raisonnements ou solutions valides restent-ils possibles lorsque le problème s'y prête ?
- La mécanique crée-t-elle une dépendance à l'aide ?
- Est-elle réellement amusante ?
- Le comportement appris est-il réutilisable ailleurs ?

Décision : **GO / MODIFY / REJECT**.

## Modification

Une modification de cette Constitution est exceptionnelle, explicite, argumentée et documentée par ADR. Une facilité technique n'est jamais une justification suffisante.
