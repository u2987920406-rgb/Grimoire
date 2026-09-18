# Tester Grimoire sur Android

Le prototype Android vise d'abord les téléphones récents en mode paysage.

## Option recommandée : APK construit par GitHub

Le dépôt contient un workflow GitHub Actions qui construit un APK de debug à chaque modification de `main`.

Depuis le téléphone :

1. ouvrir le dépôt GitHub `u2987920406-rgb/Grimoire` ;
2. ouvrir l'onglet **Actions** ;
3. choisir **Build Android APK** ;
4. ouvrir la dernière exécution réussie ;
5. dans **Artifacts**, télécharger `grimoire-android-debug` ;
6. ouvrir le ZIP téléchargé et installer `grimoire-graybox-debug.apk`.

Android peut demander l'autorisation d'installer une application provenant du navigateur ou du gestionnaire de fichiers. Cette autorisation peut être désactivée après l'installation.

## Contrôles tactiles

En paysage :
- joystick gauche : déplacement ;
- **Interagir** : action contextuelle ;
- **Poser** : visible uniquement lorsqu'un objet est porté ;
- **Lancer** : visible uniquement lorsqu'un objet est porté ;
- **Retour** : ferme dialogue ou inspection.

Le clavier PC reste disponible en parallèle.

## Alternative : export depuis Godot sur PC

Godot 4.7.2-stable peut exporter directement l'APK avec le preset **Android Debug** lorsque Java 17, le SDK Android et les templates d'export sont installés.

## Premier test Pixel

Vérifier surtout :
- orientation paysage correcte ;
- boutons accessibles avec les pouces ;
- joystick confortable ;
- texte lisible ;
- aucun bouton masqué par l'interface système ;
- déplacement fluide ;
- pomme manipulable ;
- interaction charrette/roue ;
- inspection ☀ III ;
- absence d'erreurs ou de fermeture inattendue.

Les dimensions et positions des contrôles restent provisoires jusqu'au premier test sur appareil réel.
