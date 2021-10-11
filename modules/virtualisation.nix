{pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  virtualisation = {
    virtualbox.host.enable = true;
    docker = {
      enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
}