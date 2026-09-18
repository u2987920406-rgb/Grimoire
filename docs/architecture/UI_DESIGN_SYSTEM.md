# UI Design System — principes v0.1

## Règle centrale

**Le skin peut changer. L'UX fondamentale ne change pas.**

Une aventure peut donner au journal l'apparence d'un parchemin, d'une tablette spatiale ou d'un carnet scientifique. Sa fonction, sa hiérarchie et ses interactions fondamentales restent familières.

## Composants partagés envisagés

- PrimaryButton
- SecondaryButton
- IconButton
- DialogueBubble
- ChoiceCard
- InventorySlot
- ObjectCard
- DiscoveryCard
- JournalPage
- HintPrompt
- PausePanel
- SettingsPanel

La liste n'est pas encore une API gelée.

## États minimum

Tout contrôle interactif concerné doit prévoir selon le support :
- normal ;
- hover ;
- pressed ;
- keyboard/controller focus ;
- disabled ;
- feedback visuel ;
- feedback sonore pertinent.

## Principes enfant

- peu de texte lorsque l'action peut être comprise visuellement ;
- affordances claires sans surcharger l'écran ;
- animations courtes et informatives ;
- feedback immédiat ;
- contrôles cohérents d'une aventure à l'autre ;
- pas de HUD scolaire permanent ;
- accessibilité prévue dès le Design System.

## Grimoire

Le Grimoire remplace autant que possible le menu froid traditionnel. Il sert de portail vers les aventures et de mémoire visuelle du parcours.

Transition cible : page illustrée -> rapprochement caméra -> illustration prenant du relief -> entrée dans le monde 3D. La faisabilité et le coût seront prototypés avant engagement définitif.
