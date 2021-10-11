{pkgs,...}:
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      
      keep-outputs = true
      cores = 4
      connect-timeout = 3
      max-jobs = 6
      min-free = ${toString (500 * 1024 * 1024)}
      max-free = ${toString (5 * 1024 * 1024 * 1024)}
    '';

    # Enable automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # Detect files in the store that have identical contents,
    # and replace them with hard links to a single copy.
    autoOptimiseStore = true;

    optimise = {
      # Automatically run the nix optimiser at a specific time
      automatic = true;
      dates = [ "07:00" ];
    };
   };
}