# NixOS Lenovo T14 Configuration

> For further information, please refer to the [documentation](https://nixos.org/manual/nixos/stable/)

![Desktop](./img/desktop.png)

## Getting Started

First, install NixOS as it is recommended by the official documentation.
If full disk encryption is required, read [here](https://nixos.wiki/wiki/Full_Disk_Encryption) for more information.

Build the project:

```sh
# Update channels
nix-channel update
# Update flake
nix flake update
# Update system
nixos-rebuild switch  --flake '.#stefan' --upgrade
```

Clean old generations:

```sh
nix-env -p /nix/var/nix/profiles/system --delete-generations old
nix-collect-garbage -d
nix-env -p /nix/var/nix/profiles/system --list-generations
## Remove entries from /boot/loader/entries:
sudo bash -c "cd /boot/loader/entries; ls | grep -v <current-generation-name> | xargs rm"
```

Make sure `flake` is already available during set up otherwise it might fail.

### Building custom host

To build a custom host, just copy a default one and adapt to your needs.
**Important: install bootloader might fail, add `--install-bootloader` during NixOS build**

### VS Code

Use extension [i3](https://marketplace.visualstudio.com/items?itemName=dcasella.i3) with `i3` config to lint your profile:

```json
"files.associations": {
"**/.i3/config": "i3",
"**/i3/config": "i3",
"**/i3/config/*": "i3",
},
```

### i3

```sh
# Restart and reload
i3-msg reload
i3-msg restart
```

## Keyboard Configuration

> More information [documentation](https://nixos.org/manual/nixos/stable/index.html#custom-xkb-layouts)

By default, I use a US layout. However, I need german umlauts so I added a custom layout. Only one problem is that I cannot set it as default. Please run:

```sh
setxkbmap us-de
```

## Printer Configuration

For personal use, I have Canon printers like MF522. To add a printer please refer to the [documentation](http://localhost:631/)

```sh
lpadmin -p Canon-XXXXX -E -v ipp://XXX.XXX.X.XX/ipp/print -m everywhere
```

## Networkmanager

* `tmui`: configure Wifi connection

## Display & Screens

Set `multilockscreen`:

```sh
betterlockscreen -u ~/Documents/nixos-artwork/wallpapers/nix-wallpaper-nineish-dark-gray.svg --display 1 --span
betterlockscreen -u path_to_file --fx dim,pixel
```

Set background:

```sh
nitrogen --no-recurse ~/Documents/git/nixos-artwork/wallpapers
```

Set up new display:

```sh
# See what displays are available
xrandr
# Set display
xrandr --output DisplayPort-1 --auto --left-of eDP
# Save
autorandr --save
```

### Fonts

#### VSCode and Zsh

Set the font in the `settings.json` correctly:
```json
{
"terminal.integrated.fontFamily": "'Source Code Pro for Powerline', 'Hack Nerd Font'"
}
```

## Other

* `nitrogen`: Change background
* `multilockscreen`: Lock i3

## Credits

* [NixOS Flake Example](https://github.com/colemickens/nixos-flake-example)
* [vyorkin](https://github.com/vyorkin/nixos-config/)
* [mitchellh](https://github.com/mitchellh/nixos-config)
