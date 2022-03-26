{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libnotify
  ];
  
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
          astroid.enable = true;
          notmuch.enable = true;
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
            tls = {
              useStartTls = true;
            };
          };
          userName = "stefan-machmeier@outlook.com";
        };
        work = {
          address = "stefan.machmeier@urz.uni-heidelberg.de";
          imap = {
            host = "exchange.uni-heidelberg.de";
            port = 143;
            tls = {
              useStartTls = true;
            };
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
                AuthMechs = "PLAIN";
                Timeout = 120;
                PipelineDepth = 1;
              };
            };
          };
          msmtp = {
            enable = true;
          };
          astroid.enable = true;
          notmuch.enable = true;
          primary = true;
          realName = "Stefan Machmeier";
          signature = {
            text = ''
              Mit besten Wünschen
            '';
            showSignature = "append";
          };
          passwordCommand = "${pkgs.gnupg}/bin/gpg -q --for-your-eyes-only --no-tty --exit-on-status-write-error --batch --recipient stefan-machmeier@outlook.com --passphrase-file ${config.users.users.stefan.home}/private.pass -d ${config.users.users.stefan.home}/work.pass.gpg";
          smtp = {
            host = "exchange.uni-heidelberg.de";
            port = 587;
            tls = {
              useStartTls = true;
            };
          };
          userName = "m8g";
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
      afew = {
        enable = true;
        extraConfig = ''
          [SpamFilter]
          [KillThreadsFilter]
          [ListMailsFilter]
          [ArchiveSentMailsFilter]
          [FolderNameFilter]
          maildir_separator = /

          [MailMover]
          folders = private/Inbox work/Inbox
          rename = true

          private/Inbox = 'NOT tag:Inbox':"private/Inbox"
          work/Inbox = 'NOT tag:Inbox':"work/Inbox"
        '';
      };

      astroid = {
        enable = true;
        externalEditor = "emacsclient -c";
        extraConfig = {
          startup.queries.inbox_private = "folder:private/Inbox";
          startup.queries.inbox_work = "folder:work/Inbox";
        };
      };  
    };

    home.file."bin/msmtp" = {
      text = ''
      #!${pkgs.stdenv.shell}
      ${pkgs.libnotify}/bin/notify-send "Sending mail ✉️"
      ${pkgs.msmtp}/bin/msmtp --read-envelope-from $@
      '';
      executable = true;
    };

    home.file."bin/msync" = {
      text = ''
      #!${pkgs.stdenv.shell}
      ${pkgs.libnotify}/bin/notify-send "Syncing mails 📫️"
      systemctl --user start mbsync
      '';
      executable = true;
    };

    services.mbsync = {
      enable = true;
      preExec = "${config.users.users.stefan.home}/mbsync/preExec";
      postExec = "${config.users.users.stefan.home}/mbsync/postExec";
      frequency = "*:0/30";
    };
    
    home.file."mbsync/preExec" = {
      text = ''
      #!${pkgs.stdenv.shell}

      export NOTMUCH_CONFIG=${config.users.users.stefan.home}/.config/notmuch/default/config

      ${pkgs.coreutils}/bin/mkdir -p ${config.users.users.stefan.home}/mails/private ${config.users.users.stefan.home}/mails/work
      # ${pkgs.afew}/bin/afew -C ${config.users.users.stefan.home}/.config/notmuch/default/config -m -v
      '';
      executable = true;
    };

    home.file."mbsync/postExec" = {
      text = ''
      #!${pkgs.stdenv.shell}

      export NOTMUCH_CONFIG=${config.users.users.stefan.home}/.config/notmuch/default/config

      ${pkgs.notmuch}/bin/notmuch new
      # ${pkgs.afew}/bin/afew -C ${config.users.users.stefan.home}/.config/notmuch/default/config --tag --new -v
      # Remove inbox (lower-case)
      ${pkgs.notmuch}/bin/notmuch tag -inbox -- tag:Inbox
      # Remove Inbox tagged message that are not in an Inbox
      ${pkgs.notmuch}/bin/notmuch tag -Inbox -- not folder:private/Inbox not folder:work/Inbox and tag:Inbox
      ${pkgs.libnotify}/bin/notify-send "Mails synced 📬"
      '';
      executable = true;
    };
  };
}