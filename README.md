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
multilockscreen -u path_to_file --fx dim,pixel
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

## Doom-Emacs

```sh

```


## Mail Configuration

For GPG use `gpg`:

First, load your private key into GPG
```sh
# Import key 
gpg --import private.key
# Trust key
expect -c 'spawn gpg --edit-key {KEY} trust quit; send "5\ry\r"; expect eof'
# Or 
gpg --edit-key {KEY} trust quit
# enter 5<RETURN> (I trust ultimately)
# enter y<RETURN> (Really set this key to ultimate trust - Yes)
```

For S/MIME use `gpgsm`:

```sh
# Extract key and cert
openssl pkcs12 -in keycert.p12 -out keycert.pem -nodes
# Extract private key
openssl pkcs12 -in keycert.pem -export -out key.p12 -nocerts -nodes
# Load key
gpgsm --import key.p12

# Extracting cert
openssl pkcs12 -in keycert.p12 -out certs.pem -nokeys
# Load cert
gpgsm --import certs.pem

# Testing
# Sign a random file, create file before
gpgsm --detach-sign file > sig
gpgsm --verify sig file

# Add to trusted
gpgsm --list-keys 2>/dev/null | grep fingerprint | awk '{print $2 " S"}' >> ~/.gnupg/trustlist.txt
```

For more information, follow [this](https://www.claws-mail.org/faq/index.php/S/MIME_howto) and [this](https://www.mew.org/en/feature/smime.html).

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