{ config, lib, pkgs, inputs, ... }:

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
          primary = lib.mkIf ( config.networking.hostName == "nixos-stefan") true;
          msmtp.enable = true;
          astroid.enable = true;
          notmuch.enable = true;
          realName = "Stefan Machmeier";
          signature = {
            text = ''
              --
              Stefan Machmeier

              Email: stefan-machmeier@outlook.com

              Encryption
              OpenPGP: https://keys.openpgp.org/vks/v1/by-fingerprint/EC4C531C2E0F840C746429D4A0CBC9D2A1914257
            '';
            showSignature = "attach";
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
          msmtp.enable = true;
          astroid.enable = true;
          notmuch.enable = true;
          primary =  lib.mkIf ( config.networking.hostName == "nixos-work") true;
          realName = "Stefan Machmeier";
          signature = {
            text = ''
              --
              Stefan Machmeier
              Kernteam IT-Sicherheit
              Universitätsrechenzentrum (URZ)
              Universität Heidelberg
              Im Neuenheimer Feld 330, 69120 Heidelberg
              stefan.machmeier@urz.uni-heidelberg.de
            '';
            showSignature = "attach";
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
        # Only used when service mbsync not running
        hooks = {
          preNew = "mbsync --all";
        };
        new.tags = ["new"];
      };
      afew = {
        enable = true;
        extraConfig = ''
          [FolderNameFilter]
          folder_transforms = trash:deleted Archiv:archive Archive:archive
          maildir_separator = /
          folder_lowercases = true
          [SpamFilter]
          [KillThreadsFilter]
          [ListMailsFilter]
          [ArchiveSentMailsFilter]
          [SentMailsFilter]
          sent_tag = sent
          
          [Filter.1]
          query = to:stefan.machmeier@urz.uni-heidelberg.de
          tags = +work
          message = Tag work mails

          [Filter.2]
          query = to:stefan-machmeier@outlook.com
          tags = +private
          message = Tag private mails

          [Filter.3]
          query = 'to:stefan.machmeier@stud.uni-heidelberg.de OR to:tz251@stud.uni-heidelberg.de'
          tags = +uni
          message = Tag uni mails

          [Filter.4]
          query = from:LAGEZENTRUM@CYBERSICHERHEIT.BWL.DE
          tags = +bsi
          message = Tag BSI mails

          [Filter.5]
          query = tag:bsi
          tags = -new;-inbox
          message = Remove BSI mails

          [Filter.6]
          query = path:private/Archiv/**
          tags = +archive;-new
          message = Remove archvie messages

          [Filter.7]
          query = path:work/Archive/**
          tags = +archive;-new
          message = Remove archvie messages

          [Filter.8]
          query = tag:calendar
          tags = -new
          message = Remove calendar messages

          [Filter.9]
          query = tag:trash OR tag:"deleted items"
          tags = -new;-trash;+deleted
          message = Remove deleted messages

          [Filter.10]
          query = path:draft
          tags = +draft
          message = Add draft messages

          [InboxFilter]

          [MailMover]
          folders = work/Inbox
          rename = True
          max_age = 15

          # rules
          work/Inbox = 'tag:bsi':work/Inbox/BSI
        '';
      };

      astroid = {
        enable = true;
        #pollScript = "${pkgs.notmuch}/bin/notmuch new && ${pkgs.afew}/bin/afew -C ${config.users.users.stefan.home}/.config/notmuch/default/config --tag --new -v && ${pkgs.afew}/bin/afew -C ${config.users.users.stefan.home}/.config/notmuch/default/config --move --new -v";
        pollScript = "mbsync -a";
        #externalEditor = "emacsclient -q -c %1";
        extraConfig = {
          startup.queries.inbox_private = "folder:private/Inbox";
          startup.queries.inbox_work = "folder:work/Inbox";
          poll.interval = 30;
        };
      };  
    };

    services.mbsync = {
      enable = true;
      preExec = "${config.users.users.stefan.home}/mbsync/preExec";
      postExec = "${config.users.users.stefan.home}/mbsync/postExec";
      frequency = "*:0/1";
    };

    home.file = {
      "bin/msmtp" = {
        text = ''
        #!${pkgs.stdenv.shell}
        ${pkgs.libnotify}/bin/notify-send "Sending mail ✉️"
        ${pkgs.msmtp}/bin/msmtp --read-envelope-from $@
        '';
        executable = true;
      };
      "bin/msync" = {
        text = ''
        #!${pkgs.stdenv.shell}
        systemctl --user start mbsync -a
        '';
        executable = true;
      };
      "mbsync/preExec" = {
        text = ''
        #!${pkgs.stdenv.shell}

        ${pkgs.coreutils}/bin/mkdir -p ${config.users.users.stefan.home}/mails/private ${config.users.users.stefan.home}/mails/work
        '';
        executable = true;
      };
      "mbsync/postExec" = {
        text = ''
        #!${pkgs.stdenv.shell}

        ${pkgs.afew}/bin/afew -C ${config.users.users.stefan.home}/.config/notmuch/default/config --tag --new -v
        ${pkgs.afew}/bin/afew -C ${config.users.users.stefan.home}/.config/notmuch/default/config --move --new -v
        '';
        executable = true;
      };
      ".signature.work" = { source = ./signature.work; };
      ".signature.prv" = { source = ./signature.prv; };
    };
  };
}