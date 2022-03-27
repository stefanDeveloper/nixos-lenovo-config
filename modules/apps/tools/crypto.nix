{ pkgs, ... } :
{ 
  environment.systemPackages = with pkgs; [
    openssl
  ];
  services.pcscd.enable = true;
  
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  home-manager.users.stefan = {
      home.file = {
      ".gnupg/gpg.conf" = { source = "${inputs.gpg-conf}/gpg.conf"; };
      ".gnupg/gpgsm.conf" = { source = "${inputs.gpg-conf}/gpgsm.conf"; };
      ".gnupg/gpg-agent.conf" = { source = "${inputs.gpg-conf}/gpg-agent.conf"; };
    };
  };
}