{ pkgs, ... }:
{
  nix = {
    # use unstable nix so we can access flakes
    package = pkgs.nixUnstable;
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

    settings.substituters = ["https://stefan-nixos.cachix.org"];
    settings.trusted-public-keys = ["stefan-nixos.cachix.org-1:S1iE7zFwwpUesnnKkihuLgZKWtaG3Buf7Ca/QZtQzzM="];

    optimise = {
      # Automatically run the nix optimiser at a specific time
      automatic = true;
      dates = [ "07:00" ];
    };
  };
}
