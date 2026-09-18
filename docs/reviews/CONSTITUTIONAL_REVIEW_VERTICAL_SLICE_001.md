# Revue constitutionnelle — Vertical Slice 001

**Date : 18 septembre 2026**  
**Périmètre : La Vallée oubliée, 0–15 min + Adventure Contract v0.2**  
**Décision globale : GO avec deux ajustements mineurs**

## JEU-01 — Jeu avant pédagogie
**GO.** Le slice commence par exploration, manipulation et curiosité. Aucune séquence scolaire explicite.

## COG-01 — Propriété du raisonnement
**GO.** Les dialogues sont courts et ne donnent pas la solution. Le monde répond principalement par ses conséquences.

## EXP-01 — Expérimenter avant d'expliquer
**GO.** La pomme dans l'eau, la roue et la borne sont comprises par interaction directe.

## MONDE-01 / REAL-01 — Cohérence du monde
**GO.** Les comportements prévus sont déterministes et causaux.

**Ajustement :** ne pas introduire de comparaison de matériaux dans le premier slice tant qu'un vrai cas de gameplay ne la justifie. La notion reste prévue pour l'aventure complète.

## CREA-01 / CREA-02 — Solutions et liberté
**GO.** La réussite est fondée sur l'état du monde. Les familles de solutions de la charrette restent candidates et ne seront conservées que si elles sont plausibles en prototype.

## HUMAIN-01 — Cohérence humaine
**GO.** Le propriétaire de la charrette réagit aux actions ; aucune action physiquement possible n'est automatiquement socialement neutre.

## ECHEC-01 — Échec informatif
**GO.** La roue qui retombe et la dérive des objets fournissent une information visible plutôt qu'un écran d'échec.

## SAVOIR-01 / TRANSFERT-01
**GO pour le périmètre.** Le premier slice n'a pas besoin de démontrer toute la boucle de transfert. Il prépare l'observation et le rappel.

## IA-01 / IA-02
**GO.** Aucun LLM requis.

## UX-01
**GO.** Les interactions minimales peuvent devenir le langage partagé des aventures.

**Ajustement :** `carry` doit être considéré comme un état de manipulation après `take`, pas comme une action contextuelle indépendante proposée au joueur.

## ARCH-01
**GO.** La séparation Core / UI / Adventure est respectée.

## Risques à surveiller en prototype

1. Trop d'actions contextuelles visibles simultanément.
2. Physique amusante mais imprévisible au point de casser le raisonnement.
3. Caméra qui gêne la lecture des objets.
4. Première énigme de charrette trop complexe.
5. Scintillement de la borne trop explicite.
6. Dialogue qui compense un manque de lisibilité du monde.

## Critère de passage

Le slice est constitutionnellement autorisé à entrer en bootstrap technique.

La prochaine revue obligatoire aura lieu après le premier graybox réellement jouable, sur observation des comportements et non sur intention documentaire.
