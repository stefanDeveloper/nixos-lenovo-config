{ pkgs ? import <nixpkgs> {
    config = { allowUnfree = true; };
  }
}:

{
  system = pkgs.callPackage ./system {};
}