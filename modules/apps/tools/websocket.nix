{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ws no support due to lack of maintenance
  ];
}
