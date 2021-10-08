{pkgs,...}:

{
  environment.systemPackages = with pkgs; [
    # Work
    thunderbird
    filezilla
    nextcloud-client
    keepassxc
    libreoffice

    openconnect
    remmina

    # GNOME
    gnome3.gnome-tweaks

    # Coding
    docker-compose
    vscode

    texlive.combined.scheme-full
  ];
}