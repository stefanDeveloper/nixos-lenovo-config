{ pkgs, nixpkgs-unstable, nixpkgs-old, ... }:

{
  environment.systemPackages = with pkgs; [
    thunderbird # Mail
    filezilla # SFTP, FTP client
    nixpkgs-unstable.nextcloud-client # Nextcloud client
    seafile-client # Seafile Cloud
    keepassxc # Password database
    libreoffice # Office 
    gimp # Image editing

    rdesktop
    nixpkgs-old.remmina # RPD, VNC client
    obs-studio # Recorind screen

    texlive.combined.scheme-full # Latex lib
    gthumb # edit images
    meld # compare folder

    zotero # Citation manager

    gnome3.eog # image viewer
    gnome3.evince # pdf reader
    gnome3.nautilus # file manager
    gnome3.file-roller # archive files

    obsidian

    pandoc
  ];
}
