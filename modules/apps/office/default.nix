{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    thunderbird # Mail
    filezilla # SFTP, FTP client
    nextcloud-client # Nextcloud client
    seafile-client # Seafile Cloud
    keepassxc # Password database
    libreoffice # Office 
    gimp # Image editing
    apache-directory-studio # LDAP

    openconnect # VPN university
    remmina # RPD, VNC client
    obs-studio # Recorind screen

    texlive.combined.scheme-full # Latex lib
    gthumb # edit images
    meld # compare folder

    zotero # Citation manager
  ];
}
