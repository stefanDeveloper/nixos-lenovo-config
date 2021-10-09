
{ inputs, ... }: 
{
  imports = with inputs.self.nixosModules; [
    gnome
  ];
}