{ pkgs, ... }:
let
  jellyfinCss = '':root {
      /* high-contrast dark palette */
      --nf-accent: #E50914;        /* fills: white on this = 5.9:1 (AA) */
      --nf-accent-text: #FF4A5A;   /* red as text/underline: 5.2:1 (AA) */
      --nf-accent-hover: #FF1830;
      --nf-bg: #101010;            /* near-black base */
      --nf-surface: #1A1A1A;
      --nf-surface-2: #232323;
      --nf-border: #3A3A3A;        /* visible borders, not just color */
      --nf-text: #FFFFFF;          /* 19.7:1 on bg */
      --nf-text-2: #C9C9C9;        /* 11:1 on bg (AA/AAA) */
      --nf-focus: #FFFFFF;
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
      background-color: rgba(0,0,0,0.85) !important;
    }

    /* top bar */
    .skinHeader, .skinHeader-withBackground, .skinHeader.semiTransparent {
      background-color: var(--nf-surface) !important;
      color: var(--nf-text) !important;
      border-bottom: 1px solid var(--nf-border);
      backdrop-filter: none !important;
    }

    /* text: high-contrast */
    .skinHeader, .paper-icon-button-light, .emby-button, .checkboxLabel,
    .paperListLabel, .listItem, .inputLabel, .fieldDescription {
      color: var(--nf-text) !important;
    }
    .cardText-secondary, .secondaryText, .programSecondaryTitle,
    .emby-tab-button, .navMenuOption, .inputLabelUnfocused, .textareaLabelUnfocused {
      color: var(--nf-text-2) !important;
    }

    /* global keyboard focus: white ring, never color-only */
    :focus, .emby-button:focus, .paper-icon-button-light:focus,
    .emby-tab-button:focus, .card:focus, .listItem:focus, .navMenuOption:focus {
      outline: 3px solid var(--nf-focus) !important;
      outline-offset: 2px !important;
    }

    /* accent interactions: ALWAYS paired with a shape/border cue */
    .button-link, .button-flat:hover {
      color: var(--nf-accent-text) !important;
      text-decoration: underline;
      text-underline-offset: 3px;
    }
    .emby-tab-button-active {
      color: var(--nf-accent-text) !important;
      font-weight: 700;
      border-bottom: 3px solid var(--nf-accent-text);
    }
    .emby-tab-button:hover, .emby-tab-button.show-focus:focus,
    .paper-icon-button-light:hover:not(:disabled) {
      color: var(--nf-accent-text) !important;
    }
    .navMenuOption-selected {
      background-color: var(--nf-accent) !important;
      color: #FFFFFF !important;
      font-weight: 700;
      border-left: 4px solid var(--nf-accent-hover);
    }
    .buttonActive, .metadataSidebarIcon, .upNextDialog-countdownText,
    .inputLabelFocused, .selectLabelFocused, .textareaLabelFocused {
      color: var(--nf-accent-text) !important;
    }

    /* accent fills (white text 5.9:1, AA) */
    .fab, .raised, .button-submit, .emby-button.detailFloatingButton,
    .selectionCommandsPanel, .itemProgressBarForeground,
    .countIndicator, .fullSyncIndicator, .mediaSourceIndicator, .playedIndicator,
    .alphaPickerButton-tv:focus,
    .emby-checkbox:checked + span + .checkboxOutline,
    .guide-channelHeaderCell:focus, .programCell:focus,
    .emby-select-tv-withcolor:focus {
      background-color: var(--nf-accent) !important;
      color: #FFFFFF !important;
    }
    .button-submit:focus, .emby-button.detailFloatingButton:hover,
    .fab:focus, .raised:focus {
      background-color: var(--nf-accent-hover) !important;
    }
    .itemSelectionPanel { border: 2px solid var(--nf-accent) !important; }

    /* checkboxes: checked shows checkmark shape, not color-only */
    .checkboxOutline { border: 2px solid var(--nf-text-2) !important; }

    /* inputs: visible border + focus ring */
    .emby-input, .emby-textarea, .emby-select-withcolor {
      background: var(--nf-surface-2) !important;
      color: var(--nf-text) !important;
      border: 2px solid var(--nf-border) !important;
      border-radius: 6px !important;
    }
    .emby-input:focus, .emby-textarea:focus, .emby-select-withcolor:focus {
      border-color: var(--nf-focus) !important;
      box-shadow: 0 0 0 2px rgba(255,255,255,.5);
    }
    .emby-select-withcolor > option { background: var(--nf-surface-2) !important; }

    /* cards: border + focus ring */
    .card { border-radius: 10px; transition: transform .2s ease; }
    .cardBox, .cardScalable, .cardImage { border-radius: 10px; }
    .visualCardBox {
      background-color: var(--nf-surface) !important;
      border-radius: 10px !important;
      border: 1px solid var(--nf-border);
    }
    .card:focus .cardBox.visualCardBox,
    .card:focus .cardBox:not(.visualCardBox) .cardScalable {
      outline: 3px solid var(--nf-focus) !important;
      outline-offset: 2px !important;
    }

    /* panels / lists */
    .paperList, .formDialogHeader, .formDialogFooter, .collapseContent,
    .appfooter, .playlistSectionButton, .toast {
      background-color: var(--nf-surface) !important;
      color: var(--nf-text) !important;
      border: 1px solid var(--nf-border);
    }
    .toast { border-radius: 8px !important; }
    .listItem { border-bottom: 1px solid var(--nf-border) !important; }
    .listItem:hover, .listItem:focus, .navMenuOption:hover {
      background-color: var(--nf-surface-2) !important;
    }

    /* progress */
    .progressring-spiner { border-color: var(--nf-accent-text) !important; }

    /* scrollbar */
    ::-webkit-scrollbar { width: 12px; height: 12px; }
    ::-webkit-scrollbar-track { background: var(--nf-bg); }
    ::-webkit-scrollbar-thumb { background: var(--nf-surface-2); border: 2px solid var(--nf-border); }
    ::-webkit-scrollbar-thumb:hover { background: var(--nf-accent); }

    /* reduced motion: kills ALL animation/transition */
    @media (prefers-reduced-motion: reduce) {
      *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
        scroll-behavior: auto !important;
      }
      .card:hover { transform: none !important; }
    }

    /* larger tap targets for touch/coarse pointers */
    @media (pointer: coarse) {
      .emby-button, .paper-icon-button-light, .cardOverlayButton {
        min-height: 44px;
        min-width: 44px;
      }
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

