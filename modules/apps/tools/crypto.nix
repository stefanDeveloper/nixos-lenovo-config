{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    openssl
    gpg-tui
    sshpass
    libsForQt5.kleopatra
  ];
  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  home-manager.users.stefan = {
    home.file = {
      ".gnupg/gpg.conf" = { source = "${inputs.gpg-config}/gpg.conf"; };
      ".gnupg/gpgsm.conf" = { source = "${inputs.gpg-config}/gpgsm.conf"; };
      ".gnupg/gpg-agent.conf" = { source = "${inputs.gpg-config}/gpg-agent.conf"; };
    };
  };
}
