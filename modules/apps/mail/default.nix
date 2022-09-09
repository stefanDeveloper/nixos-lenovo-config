{ inputs, ... }:
{
  home-manager.users.stefan = {
    home.file = {
      ".signature.work" = { source = "${inputs.mail-signature}/signature.work"; };
      ".signature.prv" = { source = "${inputs.mail-signature}/signature.prv"; };
    };
  };
}
