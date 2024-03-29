{ pkgs, ... }:

{
  programs.java.enable = true;
  environment.systemPackages = with pkgs; [
    cmake
    gcc11
    python39
    python39Packages.pip
    python39Packages.setuptools
    # python39Packages.jupyter

    pre-commit

    vagrant

    ansible
    ansible-lint
    jmespath

    jdk11
    maven
    gradle

    ansible
    ansible-lint

    apache-directory-studio

    nixpkgs-fmt

    clang
    clang-tools

    powershell
    mono

    qemu-utils

    cookiecutter
  ];
}
