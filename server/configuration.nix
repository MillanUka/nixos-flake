{ pkgs, ... }:
let
  jellyfinCss = '':root {
      --nf-accent: #E50914;
      --nf-accent-text: #FF4A5A;
      --nf-accent-hover: #FF1830;
      --nf-bg: #141414;
      --nf-surface: #1C1C1C;
      --nf-surface-2: #242424;
      --nf-border: #2C2C2C;
      --nf-text: #F5F5F5;
      --nf-text-2: #A6A6A6;
      --nf-font: 'Helvetica Neue', 'Segoe UI', Roboto, Arial, sans-serif;
    }

    html, body {
      font-family: var(--nf-font);
      background-color: var(--nf-bg);
      color: var(--nf-text);
    }

    /* surfaces */
    .backgroundContainer, .dialog, .mainDrawer, .drawer-open,
    .noBackdropTransparency .detailPageSecondaryContainer, .wizardStartForm {
      background-color: var(--nf-bg) !important;
    }
    .backgroundContainer.withBackdrop {
      background-color: rgba(0,0,0,0.82) !important;
    }

    /* top bar */
    .skinHeader, .skinHeader-withBackground, .skinHeader.semiTransparent {
      background-color: var(--nf-surface) !important;
      color: var(--nf-text) !important;
      backdrop-filter: none !important;
    }

    /* base text readability */
    .skinHeader, .paper-icon-button-light, .emby-button, .checkboxLabel,
    .paperListLabel, .listItem, .inputLabel, .fieldDescription {
      color: var(--nf-text) !important;
    }
    .cardText-secondary, .secondaryText, .programSecondaryTitle,
    .emby-tab-button, .navMenuOption, .inputLabelUnfocused, .textareaLabelUnfocused {
      color: var(--nf-text-2) !important;
    }

    /* accent red as text/ink — #FF4A5A (>=4.5:1 on dark) */
    .paper-icon-button-light:hover:not(:disabled),
    .paper-icon-button-light:active:not(:disabled),
    .emby-tab-button-active,
    .emby-tab-button.show-focus:focus,
    .emby-tab-button:hover,
    .button-flat:hover, .button-link,
    .alphaPickerButton-tv:focus,
    .guide-date-tab-button.emby-tab-button-active,
    .guide-date-tab-button:focus,
    .buttonActive, .metadataSidebarIcon, .upNextDialog-countdownText,
    .inputLabelFocused, .selectLabelFocused, .textareaLabelFocused {
      color: var(--nf-accent-text) !important;
    }

    /* accent red as fill — #E50914 with white text (5.8:1, AA) */
    .fab, .raised, .button-submit, .emby-button.detailFloatingButton,
    .navMenuOption-selected, .selectionCommandsPanel, .itemProgressBarForeground,
    .countIndicator, .fullSyncIndicator, .mediaSourceIndicator, .playedIndicator,
    .alphaPickerButton-tv:focus,
    .emby-checkbox:checked + span + .checkboxOutline,
    .guide-channelHeaderCell:focus, .programCell:focus,
    .emby-select-tv-withcolor:focus {
      background-color: var(--nf-accent) !important;
    }
    .button-submit:focus, .emby-button.detailFloatingButton:hover,
    .fab:focus, .raised:focus {
      background-color: var(--nf-accent-hover) !important;
    }
    .itemSelectionPanel { border-color: var(--nf-accent) !important; }

    /* focus visibility */
    .emby-button.show-focus:focus,
    .paper-icon-button-light.show-focus:focus,
    .emby-tab-button.show-focus:focus {
      outline: 2px solid var(--nf-text);
      outline-offset: 1px;
    }

    /* inputs */
    .emby-input, .emby-textarea, .emby-select-withcolor {
      background: var(--nf-surface-2) !important;
      color: var(--nf-text) !important;
      border: 1px solid var(--nf-border) !important;
      border-radius: 6px !important;
    }
    .emby-input:focus, .emby-textarea:focus, .emby-select-withcolor:focus {
      border-color: var(--nf-accent-text) !important;
      box-shadow: 0 0 0 2px rgba(255,74,90,.35);
    }
    .emby-select-withcolor > option {
      background: var(--nf-surface-2) !important;
    }

    /* cards */
    .card {
      border-radius: 10px;
      transition: transform .2s ease;
    }
    .card:hover { transform: translateY(-3px); }
    .cardBox, .cardScalable, .cardImage { border-radius: 10px; }
    .visualCardBox {
      background-color: var(--nf-surface) !important;
      border-radius: 10px !important;
    }
    .card:focus .cardBox.visualCardBox,
    .card:focus .cardBox:not(.visualCardBox) .cardScalable {
      border-color: var(--nf-accent-text) !important;
      box-shadow: 0 0 0 2px rgba(255,74,90,.45);
    }

    /* panels / overlays */
    .paperList, .formDialogHeader, .formDialogFooter, .collapseContent,
    .appfooter, .playlistSectionButton, .toast {
      background-color: var(--nf-surface) !important;
      color: var(--nf-text) !important;
    }
    .toast { border-radius: 8px !important; }
    .listItem:hover, .listItem:focus, .navMenuOption:hover {
      background-color: var(--nf-surface-2) !important;
    }

    /* progress */
    .progressring-spiner { border-color: var(--nf-accent-text) !important; }

    /* scrollbar */
    ::-webkit-scrollbar { width: 10px; height: 10px; }
    ::-webkit-scrollbar-track { background: var(--nf-bg); }
    ::-webkit-scrollbar-thumb { background: #3A3A3A; border-radius: 5px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--nf-accent); }

    /* reduced motion */
    @media (prefers-reduced-motion: reduce) {
      .card, .emby-button, .paper-icon-button-light, .listItem, .navMenuOption {
        transition: none !important;
      }
      .card:hover { transform: none !important; }
    }  '';

  jellyfinCssFile = pkgs.writeText "jellyfin-custom.css" jellyfinCss;
in {
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  hardware.enableAllFirmware = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_NZ.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "nz";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.jellyfin.enable = true;

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.flaresolverr = {
    enable = true;
  };

  systemd.services.qbittorrent = {
    description = "qBittorrent headless";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "millanu";
      UMask = "0002";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8080";
      Restart = "on-failure";
    };
  };

  programs.kdeconnect.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  users.groups.media = {};

  users.users.millanu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "sonarr" "radarr" "media" ];
    shell = pkgs.nushell;
  };

  users.users.sonarr.extraGroups = [ "media" ];
  users.users.radarr.extraGroups = [ "media" ];
  users.users.jellyfin.extraGroups = [ "media" ];


  environment.systemPackages = with pkgs; [
    helix
    git
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    cloudflared
    qbittorrent-nox
    nushell
  ];

  services.cloudflared = {
    enable = true;
    tunnels = {
      "server" = {
        credentialsFile = "/var/lib/cloudflared/home.json";
        default = "http://localhost:8097";
      };
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts."millanuka.com" = {
      root = "/var/www/millanuka.com";
    };

    virtualHosts."www.millanuka.com" = {
      globalRedirect = "http://millanuka.com";
    };

    virtualHosts."jellyfin-theme" = {
      listen = [{
        addr = "127.0.0.1";
        port = 8097;
      }];
      locations."= /custom.css" = {
        alias = jellyfinCssFile;
        extraConfig = ''
          add_header Cache-Control "no-store";
        '';
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
        extraConfig = ''
          sub_filter '</head>' '<link rel="stylesheet" href="/custom.css"></head>';
          sub_filter_once on;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header Accept-Encoding "";
        '';
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /media/downloads 2770 millanu media - -"
    "d /media/tvshows 0775 millanu media - -"
    "d /media/movies 0775 millanu media - -"
  ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 8080 80 443 9696 7878 8096 ];

  system.stateVersion = "25.05";
}

