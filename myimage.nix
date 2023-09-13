{ pkgs, modulesPath, lib, inputs, ... }: {

  imports = [

    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    inputs.self.nixosProfiles.desktop-i3

  ];


  # use the latest Linux kernel

  boot.kernelPackages = pkgs.linuxPackages_latest;


  # Needed for https://github.com/NixOS/nixpkgs/issues/58959

  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

}
