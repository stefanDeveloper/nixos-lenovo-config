{pkgs,...}:

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
  ];
}