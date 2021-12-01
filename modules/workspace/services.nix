{
  home-manager.users.stefan = {
    services = {
      # Automatically mount new devices
      udiskie.enable = true;
    };
  };
}
