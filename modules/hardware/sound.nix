{ pkgs, ... }:

# PulseAudio is a popular sound server for Linux.
# It is now required by a number of applications, and should be
# enabled if audio support is desired on NixOS.
# Enabling PulseAudio is sufficient to enable audio support on NixOS in most cases.

# You may need to add users to the audio group for them to be able to use audio devices:
# users.extraUsers.alice.extraGroups = [ "audio" ... ];

# More info: https://nixos.wiki/wiki/PulseAudio

{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.pulseaudio = {
    enable = false;

    # 1. Only the full build has Bluetooth support
    # 2. Enable JACK support
    package = pkgs.pulseaudioFull; # .override { jackaudioSupport = true; };

    # While pulseaudio itself only has support for the
    # SBC bluetooth codec there is out-of-tree support for AAC, APTX, APTX-HD and LDAC.
    # NixOS 21.11, in 22.05 the bt functionality is included
    # extraModules = [pkgs.pulseaudio-modules-bt];
    # For compatibility with 32-bit applications
    support32Bit = true;
  };

  home-manager.users.stefan.home.packages = with pkgs; [
    pamixer
    # A Pulseaudio mixer in Qt (port of pavucontrol).
    # Can be used to adjust all controls provided by PulseAudio.
    # See: https://github.com/lxqt/pavucontrol-qt
    lxqt.pavucontrol-qt
  ];
}
