{ pkgs, ... }:
let
  jellyfinCss = '':root {
      --nf-accent: #e50914;
      --nf-bg: #141414;
      --nf-bg-solid: #0f0f0f;
      --nf-fg: #e5e5e5;
      --nf-fg-dim: #8c8c8c;
      --nf-font: 'Helvetica Neue', 'Segoe UI', Roboto, Arial, sans-serif;
    }

    html, body {
      font-family: var(--nf-font);
      background-color: var(--nf-bg-solid);
      color: var(--nf-fg);
    }

    /* backgrounds */
    .backgroundContainer, .dialog, .mainDrawer, .drawer-open,
    .noBackdropTransparency .detailPageSecondaryContainer,
    .wizardStartForm {
      background-color: var(--nf-bg-solid) !important;
    }
    .backgroundContainer.withBackdrop {
      background-color: rgba(0,0,0,0.82) !important;
    }

    /* top bar */
    .skinHeader, .skinHeader-withBackground, .skinHeader.semiTransparent {
      background-color: #1a1a1a !important;
      color: var(--nf-fg) !important;
      backdrop-filter: none !important;
    }

    /* accent: blue -> Netflix red */
    .paper-icon-button-light:hover:not(:disabled),
    .paper-icon-button-light:active:not(:disabled),
    .paper-icon-button-light.show-focus:focus,
    .emby-button.show-focus:focus,
    .emby-tab-button-active,
    .emby-tab-button.show-focus:focus,
    .emby-tab-button:hover,
    .button-flat:hover, .button-link,
    .navMenuOption-selected,
    .alphaPickerButton-tv:focus,
    .guide-date-tab-button.emby-tab-button-active,
    .buttonActive,
    .metadataSidebarIcon,
    .upNextDialog-countdownText {
      color: var(--nf-accent) !important;
    }

    .fab, .raised, .button-submit,
    .emby-button.detailFloatingButton,
    .navMenuOption-selected,
    .selectionCommandsPanel,
    .itemProgressBarForeground,
    .countIndicator, .fullSyncIndicator, .mediaSourceIndicator, .playedIndicator,
    .alphaPickerButton-tv:focus,
    .emby-checkbox:checked + span + .checkboxOutline,
    .guide-channelHeaderCell:focus, .programCell:focus,
    .emby-select-tv-withcolor:focus {
      background-color: var(--nf-accent) !important;
    }

    .button-submit:focus {
      background-color: #f6121d !important;
    }
    .itemSelectionPanel {
      border-color: var(--nf-accent) !important;
    }

    /* inputs */
    .emby-input, .emby-textarea, .emby-select-withcolor {
      background: #1f1f1f !important;
      color: var(--nf-fg) !important;
      border-radius: 6px !important;
    }
    .emby-input:focus, .emby-textarea:focus, .emby-select-withcolor:focus {
      border-color: var(--nf-accent) !important;
    }
    .emby-select-withcolor > option {
      background: #222 !important;
    }

    /* cards */
    .card {
      border-radius: 8px;
      transition: transform .2s ease;
    }
    .card:hover {
      transform: translateY(-3px);
    }
    .cardBox, .cardScalable, .cardImage {
      border-radius: 8px;
    }
    .visualCardBox {
      background-color: #181818 !important;
      border-radius: 8px !important;
    }
    .card:focus .cardBox.visualCardBox,
    .card:focus .cardBox:not(.visualCardBox) .cardScalable {
      border-color: var(--nf-accent) !important;
      box-shadow: 0 0 0 2px rgba(229,9,20,.5);
    }
    .cardText-secondary, .secondaryText {
      color: var(--nf-fg-dim) !important;
    }

    /* panels / lists */
    .paperList, .formDialogHeader, .formDialogFooter,
    .collapseContent, .appfooter, .playlistSectionButton {
      background-color: #181818 !important;
    }
    .listItem:hover { background-color: #242424 !important; }
    .toast {
      background: #2a2a2a !important;
      color: var(--nf-fg) !important;
      border-radius: 8px !important;
    }

    /* nav menu */
    .navMenuOption {
      color: var(--nf-fg-dim) !important;
    }
    .navMenuOption:hover {
      background: #252528 !important;
    }

    /* progress */
    .progressring-spiner { border-color: var(--nf-accent) !important; }

    /* scrollbar */
    ::-webkit-scrollbar-thumb:horizontal,
    ::-webkit-scrollbar-thumb:vertical {
      background: #3b3b3b !important;
      border-radius: 4px !important;
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

