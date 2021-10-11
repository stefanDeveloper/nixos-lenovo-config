{ pkgs, config, ... }: 
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t14/amd/gen1>
    ./modules
  ];
}