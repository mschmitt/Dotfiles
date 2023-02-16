# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # This needs to be on top really :-)
  #
  environment.systemPackages = with pkgs; [
    arduino
    ansible
    anydesk
    authy
    bash
    bash-completion
    binutils
    bitwarden
    btop
    cron
    curl
    discord
    docker
    file
    firefox-wayland
    gh
    gimp
    git
    gnome.dconf-editor
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnumake
    go
    html-tidy
    inetutils
    inxi
    iperf
    iperf3
    jq
    lm_sensors
    lxterminal
    mc
    mosh
    neofetch
    nix-bash-completions
    nmap
    nodejs
    openssl
    openvpn
    pandoc
    patchelf
    pciutils
    podman
    prelink
    psmisc
    resilio-sync
    restic
    screen
    shellcheck
    smartmontools
    spotify
    steam
    sysstat
    tdesktop
    terraform
    thunderbird
    tmux
    trash-cli
    unzip
    usbutils
    vim
    virtualenv
    vscodium
    wget
    yamllint
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-9.4.4" # for authy
  ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel options
  boot.kernel.sysctl = { "kernel.sysrq" = 176; };

  networking.hostName = "nixbook-pro"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Additional sudoers rules
  security.sudo.extraRules = [
    { 
      groups = [ "wheel" ];
      runAs = "root";
    	commands = [ 
      	{ command = "sudoedit /etc/nixos/configuration.nix"; options = [ "NOPASSWD" ]; }
      	{ command = "/run/current-system/sw/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
    	];
		}
	];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # smartmontools
  services.smartd.enable = true;
  services.smartd.autodetect = true;
  services.smartd.extraOptions = [ "-i 900" ];
  services.smartd.notifications.mail.enable = false;
  services.smartd.notifications.wall.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.martin = {
    isNormalUser = true;
    description = "Martin";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.cron.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # https://discourse.nixos.org/t/error-experimental-nix-feature-nix-command-is-disabled/18089/8
  nix.settings.experimental-features = "nix-command flakes";


  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.dnsname.enable = true;
    };
  };
}

