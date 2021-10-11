{pkgs,...}:
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # Enable automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      # Automatically run the nix optimiser at a specific time
      automatic = true;
      dates = [ "07:00" ];
    };
   };
}