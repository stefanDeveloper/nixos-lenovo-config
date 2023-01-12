{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zip
    unzip
    zlib
    bzip2
    zstd
    unrar
    atool
    i7z
  ];
}
