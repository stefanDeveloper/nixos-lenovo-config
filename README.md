# Nixos Lenovo T14 Configuration

> For further information, please refer to the [documentation](https://nixos.org/manual/nixos/stable/)

## Keyboard Configuration

> More information {documentation](https://nixos.org/manual/nixos/stable/index.html#custom-xkb-layouts)

By default, I use a US layout. However, I need german umlauts so I added a custom layout. Only one problem is that I cannot set it as default. Please run:

```sh
setxkbmap us-de
```

## Printer Configuration

For personal use, I have Canon printers like MF522. To add a printer please refer to the [documentation](http://localhost:631/)

```sh
lpadmin -p Canon-XXXXX -E -v ipp://XXX.XXX.X.XX/ipp/print -m everywhere
```
