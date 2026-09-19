# Playtest mobile 001 — Retour utilisateur

**Date : 18 septembre 2026**  
**Plateforme : Android / Pixel**  
**Build : graybox 001**

## Ce qui fonctionne

Le joueur a pu :
- se déplacer ;
- prendre une pomme ;
- lancer la pomme ;
- prendre la roue ;
- replacer la roue sur la charrette ;
- reparler au PNJ.

Le prototype est volontairement sommaire visuellement à ce stade.

## Problème 1 — Réactions du PNJ non contextuelles

### Observation
Après une action significative sur la charrette, le PNJ répète exactement la même phrase qu'avant.

### Diagnostic
Le PNJ actuel ne lit pas l'état du problème. Il possède seulement une ligne statique.

### Règle de conception
Un personnage concerné par un problème doit pouvoir réagir aux changements significatifs du monde.

La réaction ne doit pas forcément être une « félicitation » : elle dépend de l'état réel.

Exemples :
- roue absente : remarque le problème ;
- roue simplement remise mais non retenue : remarque que cela semble mieux ou attend de voir si cela tient ;
- roue qui retombe : réagit à l'échec et apporte éventuellement une information sans donner la solution ;
- problème réellement résolu : gratitude/reconnaissance adaptée à la méthode utilisée.

Le dialogue doit refléter **l'état du monde**, pas une progression scriptée indépendante.

### Critère
Aucune ligne importante liée à un problème ne doit rester identique lorsque le changement d'état rend cette ligne incohérente.

## Problème 2 — Objet jeté et perdu définitivement

### Observation
Une pomme a été lancée hors de la zone utile et n'a pas été retrouvée.

### Diagnostic
Le système de manipulation permet actuellement à un objet de quitter l'espace jouable sans politique de récupération.

### Règle de conception
Tout objet manipulable doit déclarer une politique de perte cohérente avec son importance.

Trois catégories minimales :

### A — Objet consommable / non critique
Il peut être perdu sans bloquer l'aventure.

Exemple possible : une pomme décorative parmi plusieurs.

### B — Objet récupérable
Il peut sortir temporairement du chemin principal, mais le monde doit fournir un moyen naturel de le récupérer ou d'en obtenir un équivalent.

### C — Objet critique
Il ne peut jamais devenir définitivement inaccessible par une action normale du joueur.

Solutions possibles selon le contexte :
- remise à la dernière position valide hors champ ;
- récupération dans un point logique proche ;
- retour par un PNJ ;
- nouvel exemplaire cohérent disponible ;
- limite physique empêchant une perte irréversible.

Éviter un téléport visible arbitraire lorsque le joueur peut constater l'incohérence.

## Décision sur l'action « lancer »

**Ne pas supprimer globalement l'action lancer.**

Lancer est une interaction physique utile et ludique qui peut produire de vraies expérimentations.

En revanche :
- certains objets peuvent ne pas être lançables si leur nature le justifie ;
- un objet critique lançable doit avoir une politique de récupération robuste ;
- le niveau doit limiter les zones où un objet peut devenir irrécupérable.

## Conséquence architecture

Ajouter au modèle WorldObject une notion minimale de :
- `importance: NON_CRITICAL | RECOVERABLE | CRITICAL`
- politique de récupération ou stratégie équivalente si nécessaire ;
- dernière position valide pour les objets qui en ont besoin.

Ajouter aux PNJ concernés une réaction déterministe basée sur l'état du problème.

## Priorité avant nouvelles fonctionnalités

1. réactions contextuelles du propriétaire de la charrette ;
2. politique anti-perte des objets ;
3. test mobile de régression ;
4. seulement ensuite poursuivre le contenu.

## Note de conception importante

Replacer la roue sur son axe ne signifie pas nécessairement que la charrette est réparée. Dans le design actuel, la roue doit pouvoir retomber lorsqu'on pousse afin de révéler qu'elle n'est pas retenue.

Le PNJ doit donc réagir à ce qui s'est réellement produit, sans féliciter prématurément le joueur pour une réparation encore incomplète.


## Problème 3 — Déplacement et caméra couplés

### Observation
Le joystick de déplacement entraîne également un changement de vue, ce qui rend la maniabilité confuse.

### Décision
Adopter une convention double-stick :
- gauche = déplacement ;
- droite = caméra.

La caméra est découplée de la rotation du personnage et le déplacement devient relatif à la vue courante.

### Critère
Changer de direction avec le stick gauche ne doit plus faire pivoter la caméra. Seul le stick droit doit orienter la vue sur mobile.


## Problème 4 — La suggestion « pousser » doit devenir une vraie action contextuelle

### Observation
Après avoir remis la roue, le PNJ dit naturellement : « voyons si elle tient quand on pousse ». Le joueur s'attend donc à pouvoir tester la charrette.

### Décision
La charrette devient poussable sans obligation de reparler au PNJ.

L'action `Pousser` n'est proposée que lorsque :
- la roue est en place ;
- le joueur se trouve du côté cohérent pour exercer une poussée.

Depuis un autre côté, la charrette reste examinable mais ne propose pas artificiellement `Pousser`.

### Conséquence attendue
La charrette avance réellement sur une courte distance, puis la roue ressort de l'axe avec un retour lisible. Le PNJ peut ensuite réagir à cet état.

### Principe
Le dialogue peut suggérer une expérience, mais il ne doit pas devenir une condition cachée qui autorise physiquement l'action.


## Validation — boucle charrette complète

**Statut : validé sur mobile.**

Le test utilisateur confirme que :
- la roue se remet correctement sur l'essieu ;
- l'échec initial après poussée est compréhensible ;
- le trou de retenue et la cheville permettent une correction cohérente ;
- après réparation, la charrette roule dans le plan réel de ses roues ;
- la poussée n'est proposée qu'à l'avant ou à l'arrière ;
- aucune poussée latérale incohérente n'est possible ;
- les réactions du PNJ suivent correctement l'état du problème.

### Leçon de conception retenue

Pour tout objet physique important, vérifier avant livraison :
1. cohérence entre mesh et collision ;
2. axe mécanique réel ;
3. direction de mouvement permise ;
4. points d'interaction compatibles avec cette direction ;
5. comportement visible conforme à la physique attendue.

Une correction de logique ne doit jamais être considérée comme suffisante si la géométrie de l'objet raconte autre chose.
