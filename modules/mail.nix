{ config, lib, pkgs, ... }:

{
  
  home-manager.users.stefan = {
    accounts.email = {
      maildirBasePath = "mails";
      accounts = {
        private = {
          address = "stefan-machmeier@outlook.com";
          gpg = {
            key = "EC4C531C2E0F840C746429D4A0CBC9D2A1914257";
            signByDefault = true;
          };
          imap = {
            host = "outlook.office365.com";
          };
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            patterns = ["*"];
            extraConfig = {
              channel = {
                Sync = "All";
              };
              account = {
                Timeout = 120;
                PipelineDepth = 1;
              };
            };
          };
          msmtp.enable = true;
          notmuch.enable = true;
          primary = true;
          realName = "Stefan Machmeier";
          signature = {
            text = ''
              Mit besten Wünschen
            '';
            showSignature = "append";
          };
          passwordCommand = "${pkgs.gnupg}/bin/gpg -q --for-your-eyes-only --no-tty --exit-on-status-write-error --batch --recipient stefan-machmeier@outlook.com --passphrase-file ${config.users.users.stefan.home}/private.pass -d ${config.users.users.stefan.home}/prv.pass.gpg";
          smtp = {
            host = "smtp.office365.com";
          };
          userName = "stefan-machmeier@outlook.com";
        };
      };
    };
    programs = {
      mbsync.enable = true;
      msmtp.enable = true;
      notmuch = {
        enable = true;
        hooks = {
          preNew = "mbsync --all";
        };
      };
    };

  };
}