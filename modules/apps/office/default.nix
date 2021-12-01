{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    thunderbird
    filezilla
    nextcloud-client
    keepassxc
    libreoffice

    openconnect
    remmina

    texlive.combined.scheme-full
    gthumb                        # edit images
    meld                          # compare folder

    gnome3.eog                           # image viewer
    gnome3.evince                        # pdf reader
    gnome3.gnome-calendar                # calendar
    gnome3.nautilus                      # file manager
  ];
}