# dotfiles

Ce dépôt contient mes fichiers de configuration personnels (« dotfiles ») pour mon environnement Linux/Wayland.  
Il comprend la configuration de divers outils et gestionnaires de fenêtres pour un setup personnalisé.

## Contenu

- `dunst/` — configuration pour dunst (notifications)
- `hypr/` — configuration pour Hyprland (gestionnaire de fenêtres Wayland)
- `kitty/` — configuration pour kitty (terminal)
- `matugen/` — (à adapter selon usage réel)
- `rofi/` — configuration pour rofi (menu/application launcher)
- `swww/` — configuration pour swww (wallpaper/animation Wayland)
- `waybar/` — configuration pour Waybar (barre d’état Wayland)
- `wlogout/` — configuration pour wlogout (écran de sortie/lock Wayland)

## Prérequis

- Un système sous Linux avec support Wayland  
- Les logiciels listés ci-dessus installés  
- Git (pour cloner ce dépôt)  
- Les droits d’accès nécessaires pour installer les fichiers de configuration

## Installation

1. Cloner ce dépôt dans votre répertoire :  
```bash
git clone https://github.com/sticot19/dotfiles.git ~/dotfiles
```

2. Se placer dans le dossier :
```bash
cd ~/dotfiles
```

3. Copier ou lier les fichiers de configuration dans votre répertoire utilisateur. Exemple (à adapter) :

```bash
ln -s ~/dotfiles/kitty ~/.config/kitty
ln -s ~/dotfiles/hypr ~/.config/hypr
ln -s ~/dotfiles/waybar ~/.config/waybar
# etc…
```

4. Relancer ou démarrer les applications correspondantes.

## Usage

Une fois installé, mes configurations personnalisent l’apparence et le comportement de mon environnement :

* Terminal : Kitty avec thème et polices personnalisés
* Fenêtre : Hyprland avec des raccourcis & layout adaptés
* Barres et notifications : Waybar + Dunst
* Launch menu : Rofi
* Animation wallpaper : swww
* Et d’autres tweaks dans les dossiers associés

## Personnalisation

Vous pouvez modifier les fichiers selon vos goûts : thèmes, polices, couleurs…
Si vous utilisez un environnement légèrement différent (ex. : autre compositeur Wayland), adaptez les chemins et les commandes en conséquence.

## Contribuer

Les contributions sont les bienvenues !
Si vous souhaitez proposer des améliorations ou partager vos propres fichiers ou idées :

1. Forkez ce dépôt
2. Faites vos modifications
3. Ouvrez une pull request

Merci de respecter les conventions suivantes :

* Un commit clair et descriptif
* Si ajout d’un nouvel outil/fichier, ajouter une entrée dans le README ou un dossier dédié
* Bien tester avant de proposer

## Licence

Ce projet est distribué sous licence [MIT](./LICENSE.txt).


*Réalisé par sticot19*