{ lib, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "us,de";
    LANG = lib.mkForce "en_US.UTF-8";
  };
}
