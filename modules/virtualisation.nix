{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    docker = {
      enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    # Enable a daemon that manages virtual machines.
    # Docs: https://wiki.archlinux.org/index.php/libvirt
    libvirtd.enable = true;

    # Allow unprivileged user to pass USB devices connected to
    # this machine to libvirt VMs, both local and remote
    # spiceUSBRedirection.enable = true;
  };
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
}
