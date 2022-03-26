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
}