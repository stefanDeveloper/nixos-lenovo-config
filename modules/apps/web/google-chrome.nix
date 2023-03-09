{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome
    tor
    torsocks
  ];
}
