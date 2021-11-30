{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cmake
    gcc11
    python39
    python39Packages.pip
    python39Packages.setuptools
    python39Packages.jupyter

    pre-commit

    vagrant

    ansible
    ansible-lint
    jmespath

    jdk11
  ];
} 