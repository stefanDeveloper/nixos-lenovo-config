{pkgs,...}:
{
  nixpkgs.config = {
    allowUnfree = true;
  };
}