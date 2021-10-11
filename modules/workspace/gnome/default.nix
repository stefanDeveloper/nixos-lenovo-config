{pkgs, ...}:
{
    services.gnome.games.enable = false;
    environment.systemPackages = with pkgs; [
      # GNOME
      gnome3.gnome-tweaks
    ];
}