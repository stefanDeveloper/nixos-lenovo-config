{
  isNormalUser = true;
  description = "Stefan Machmeier";
  createHome = true;
  initialPassword = "whatever";
  useDefaultShell = true;
  home = "/home/stefan";
  extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
}