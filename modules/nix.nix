{ pkgs, ... }:
{
  nix = {
    # use unstable nix so we can access flakes
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    # public binary cache that I use for all my derivations. You can keep
    # this, use your own, or toss it. Its typically safe to use a binary cache
    # since the data inside is checksummed.
    # binaryCaches = ["https://stefan-nixos.cachix.org"];
    # binaryCachePublicKeys = ["stefan-nixos.cachix.org-1:S1iE7zFwwpUesnnKkihuLgZKWtaG3Buf7Ca/QZtQzzM="];

    # Enable automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings.substituters = [
      "https://stefan-nixos.cachix.org" 
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    settings.trusted-public-keys = [
      "stefan-nixos.cachix.org-1:S1iE7zFwwpUesnnKkihuLgZKWtaG3Buf7Ca/QZtQzzM="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    optimise = {
      # Automatically run the nix optimiser at a specific time
      automatic = true;
      dates = [ "07:00" ];
    };
  };
}
