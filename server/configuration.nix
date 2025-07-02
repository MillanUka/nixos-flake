{ pkgs, ... }: {
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

  programs.kdeconnect.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  users.users.millanu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };


  environment.systemPackages = with pkgs; [
    helix
    git
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    cloudflared
    qbittorrent-nox
  ];

  services.cloudflared = {
    enable = true;
    tunnels = {
      "server" = {
        credentialsFile = "/var/lib/cloudflared/home.json";
        default = "http://localhost:8096";
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
  };

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 8080 80 443 ];

  system.stateVersion = "25.05";
}

