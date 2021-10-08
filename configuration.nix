# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # If you activates this, building increase tremendously
      # ./umlauts.nix
      <nixos-hardware/lenovo/thinkpad/t14/amd/gen1>
      ./hardware-configuration.nix
      ./git.nix
    ];
  
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;  
  virtualisation.docker.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [
    wireless-regdb
  ];

  networking.hostName = "nixos-stefan"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0f0.useDHCP = true;
  networking.interfaces.enp5s0.useDHCP = true;
  # Static definition of namesserver DNS
  # environment.etc = {
  #   "resolv.conf".text = "nameserver 192.168.2.45\n";
  # };
  boot.extraModulePackages = [ config.boot.kernelPackages.rtw89 ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  services.gnome.games.enable = false;

  # Configure keymap in X11
  services.xserver.layout = "us,de";
  # services.xserver.xkbOptions = "altwin:alt_win";

  # Enable CUPS to print documents.
  # Currently not working
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ canon-cups-ufr2 ];
  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.stefan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    
  };
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Terminal/CLI
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    zip
    unzip
    htop
    killall
    pciutils
    zsh
    oh-my-zsh
    nmap
    telnet
    niv
    
    # Work
    firefox
    tor-browser-bundle-bin
    thunderbird
    google-chrome
    # termius
    filezilla
    discord
    nextcloud-client
    keepassxc
    libreoffice
    element-desktop
    openconnect
    remmina

    # GNOME
    gnome3.gnome-tweaks
    gnomeExtensions.remmina-search-provider

    # Coding
    docker-compose
    vscode
    git
    cmake
    gcc11
    python39
    python39Packages.jupyter
    texlive.combined.scheme-full
  ];


  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # GNOME
  environment.gnome.excludePackages = with pkgs; [
    gnome3.gnome-music
    gnome3.epiphany
    gnome3.yelp
    gnome3.gnome-maps
    gnome3.geary
  ];
  
  # Zsh configuration
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
      customPkgs = [
        pkgs.nix-zsh-completions
      ];
    };
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";
}

