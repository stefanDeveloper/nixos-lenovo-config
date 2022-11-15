{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prettyping
    inetutils
    iw
    openstackclient
    openvpn
    openconnect
    tcpdump
    update-systemd-resolved
  ];
}
