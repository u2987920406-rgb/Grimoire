# Vertical Slice 0–15 min — besoins réels du moteur

**Statut : spécification technique minimale avant bootstrap Godot.**

Ce document dérive directement du déroulé 0–15 minutes de `La Vallée oubliée`.

Règle : **aucun système n'entre dans le prototype s'il n'est pas justifié par une interaction concrète du vertical slice.**

## 1. Ce que le prototype doit prouver

Le prototype doit permettre de répondre à quatre questions :

1. Est-ce agréable de se déplacer dans ce monde ?
2. Est-ce amusant de manipuler les objets ?
3. Le joueur comprend-il naturellement que le monde réagit à ses actions ?
4. A-t-il envie d'aller voir ce qu'il y a plus loin ?

Le prototype n'a pas pour but de valider l'aventure complète, les mathématiques, la langue, l'IA ou le système hydraulique final.

## 2. Player Controller

Minimum nécessaire :
- déplacement 3D ;
- arrêt propre contre les obstacles ;
- orientation du personnage ;
- interaction à courte portée ;
- état `carrying` lorsqu'un objet est porté ;
- vitesse et accélération adaptées à un enfant ;
- aucun système de combat.

À valider en test :
- click-to-move ;
- ou déplacement direct clavier/manette.

Le prototype peut supporter un seul mode dans un premier temps, mais le code ne doit pas rendre l'autre impossible sans raison.

## 3. Camera Controller

Minimum :
- caméra 3D légèrement élevée ;
- suivi fluide ;
- rotation limitée ou orbitale simple ;
- zoom borné ;
- composition permettant de lire personnage + objets proches + point d'intérêt.

Mode spécial :
- `inspection_focus` pour les objets comme la borne ☀ III ;
- rapprochement vers l'objet ;
- arrière-plan atténué/flouté si possible ;
- sortie immédiate vers la caméra normale.

Pas de caméra cinématique générique complexe dans ce prototype.

## 4. Interaction System

Le joueur doit pouvoir découvrir les actions disponibles depuis le contexte.

Actions minimales du slice :
- `inspect`
- `take`
- `carry`
- `drop`
- `throw`
- `push`
- `place`
- `talk`

Une interaction doit être déterminée par les capacités réelles de l'objet et l'état du monde, pas par une liste globale toujours affichée.

Le feedback doit rester discret :
- surbrillance légère ou changement de curseur ;
- nom/icone/action si nécessaire ;
- aucune forêt de marqueurs.

## 5. WorldObject

Objet générique interactif avec au minimum :
- identifiant stable ;
- transform ;
- état actif/inactif ;
- propriétés physiques utiles ;
- capacités d'interaction ;
- état sauvegardable à terme.

Pour le slice :
- pomme ;
- caisse ;
- roue ;
- charrette ;
- borne ancienne ;
- éléments simples déplaçables.

## 6. Propriétés physiques minimales

Ne pas construire un simulateur universel.

Le prototype doit seulement représenter les propriétés nécessaires aux scènes :
- masse approximative ;
- gravité ;
- collision ;
- rigidité/corps physique ;
- flottabilité simple ;
- friction/roulement si nécessaire ;
- cassable/non cassable uniquement si utilisé ;
- attaché/détaché lorsque pertinent.

La physique sert le raisonnement. Elle doit être stable et lisible avant d'être réaliste au millimètre.

## 7. Manipulation

Le joueur doit pouvoir :
- saisir un objet autorisé ;
- le porter ;
- le poser au sol ou sur une surface valide ;
- le lancer de manière contrôlée ;
- pousser certains objets ;
- replacer la roue sur son axe.

Le système de construction libre n'est **pas** requis pour le slice 0–15 min.

Le placement de la roue peut utiliser un point d'accroche contextualisé si cela reste cohérent avec l'action visible.

## 8. Buoyancy / eau

Besoin concret : une pomme placée dans la rivière flotte et dérive.

Minimum :
- volume d'eau détectable ;
- état flottant pour certains objets ;
- force verticale simplifiée ;
- courant directionnel simple ;
- possibilité de récupérer un objet près de la berge.

Ce comportement doit être déterministe et reproductible.

## 9. Character / NPC

Un personnage non joueur minimal doit pouvoir :
- exister dans la scène ;
- lancer quelques lignes de dialogue ;
- réagir à certaines actions ;
- posséder un petit état local.

Exemples :
- reçoit une pomme ;
- remarque une pomme lancée ;
- tente de repartir ;
- déclenche la chute de la roue ;
- réagit à une réparation ou à une tentative.

Pas de système social générique complet à ce stade.

## 10. Dialogue

Minimum :
- texte court ;
- nom/personnage optionnel ;
- avance/fermeture ;
- déclenchement contextuel ;
- variations simples selon l'état du problème.

Le dialogue n'a pas le droit d'expliquer la solution à la place du joueur.

## 11. Problem State

Le moteur doit suivre l'état du problème sans imposer une recette.

Pour la charrette, exemples d'états observables :
- `wheel_attached`
- `wheel_retained`
- `cart_can_move`
- `cargo_delivered`
- `temporary_fix_active`

La réussite doit être évaluée par conditions d'état.

Ne jamais écrire un test du type :
`used_expected_item == true`

si une condition physique ou fonctionnelle suffit.

## 12. Consequence System — minimal

Le prototype doit pouvoir déclencher une conséquence lisible après un changement d'état.

Exemples :
- la roue tombe ;
- la pomme flotte ;
- le personnage réagit ;
- la charrette roule ;
- un objet reste déplacé ;
- une animation ou un son confirme une réussite.

À ce stade, un simple système de signaux/événements suffit.

Pas de moteur de règles généralisé avant usage démontré.

## 13. Attention / Inspection

Un objet important peut signaler discrètement son intérêt.

Minimum :
- état `inspectable` ;
- feedback visuel léger ;
- interaction `inspect` ;
- vue focalisée ;
- représentation claire du détail observé ;
- sortie sans friction.

Cas cible : borne ancienne **☀ III**.

## 14. Gratification

Le slice nécessite au moins :
- feedback audio/visuel lors d'une interaction réussie ;
- réaction du NPC ;
- conséquence visible ;
- gratification de découverte à la borne.

Pas de :
- XP ;
- étoiles ;
- score ;
- coffre systématique ;
- compteur de pommes.

## 15. Audio

Minimum :
- ambiance de vallée ;
- rivière ;
- bruit de charrette/roue ;
- feedback de prise/pose ;
- petites réactions du personnage ;
- son d'inspection ;
- musique légère si disponible.

L'audio participe au guidage mais ne doit pas devenir une dépendance d'accessibilité.

## 16. UI minimale

Le prototype doit pouvoir afficher uniquement ce qui est nécessaire :
- indication d'interaction contextuelle ;
- dialogue ;
- mode inspection ;
- pause minimale si nécessaire.

Pas encore requis :
- inventaire complet ;
- carte détaillée ;
- journal ;
- menu Grimoire complet ;
- écran de progression ;
- arbre de compétences.

## 17. Save/Load

Pour le tout premier graybox, la sauvegarde persistante peut être différée.

En revanche, tous les objets importants doivent avoir des identifiants et états suffisamment propres pour ne pas rendre la sauvegarde future impossible.

## 18. Systèmes explicitement hors périmètre du premier slice

- IA / LLM ;
- construction libre ;
- crafting ;
- économie ;
- quêtes génériques ;
- combat ;
- compétences ;
- XP ;
- monde ouvert ;
- météo dynamique ;
- cycle jour/nuit ;
- NPC autonomes complexes ;
- système hydraulique complet ;
- mathématiques/langue ;
- journal complet ;
- Grimoire persistant complet ;
- télémétrie distante.

## 19. Découpage technique minimal envisagé

### Core
- `player/`
- `camera/`
- `interaction/`
- `world_object/`
- `physics/`
- `dialogue/`
- `problem/`
- `events/`

### UI
- `interaction_prompt/`
- `dialogue/`
- `inspection/`

### Adventure
`adventures/forgotten_valley/`
- scène du slice ;
- NPC ;
- pommes ;
- charrette ;
- roue ;
- borne ;
- données de problème ;
- audio local.

Cette arborescence n'est créée que lorsque le bootstrap Godot commence.

## 20. Critères d'acceptation du moteur v0.1

Le moteur minimal est suffisant lorsque le parcours suivant est réellement jouable :

1. lancer le prototype ;
2. déplacer le personnage ;
3. prendre une pomme ;
4. poser/lancer la pomme ;
5. mettre la pomme dans l'eau et observer qu'elle flotte/dérive ;
6. parler au propriétaire ;
7. déplacer un objet simple ;
8. examiner la roue ;
9. remettre la roue sur l'axe ;
10. pousser la charrette et observer la conséquence ;
11. atteindre le chemin vers le village ;
12. inspecter la borne ☀ III en vue focalisée ;
13. revenir au jeu sans rupture.

Chaque action doit produire une conséquence réelle et testable.

## 21. Règle de croissance

Un nouveau système n'entre dans le Core que lorsqu'au moins un cas concret de jeu le justifie.

**Pas d'abstraction sans usage. Pas de fonctionnalité simulée présentée comme terminée.**
