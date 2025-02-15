{ config, pkgs, inputs ,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/kde.nix
      #../../modules/gnome.nix
      #../../modules/office.nix
      #../../modules/podman.nix
      #../../modules/waydroid.nix
      ../../modules/nix-ld.nix
      ../../modules/syspkg.nix
      #../../modules/java.nix
      ../../modules/games.nix
      #../../modules/virt-manager.nix
      #../../modules/virtualbox.nix
      inputs.home-manager.nixosModules.default
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device="nodev";
  networking.hostName = "holox360";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  zramSwap.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "el_GR.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT = "el_GR.UTF-8";
    LC_MONETARY = "el_GR.UTF-8";
    LC_NAME = "el_GR.UTF-8";
    LC_NUMERIC = "el_GR.UTF-8";
    LC_PAPER = "el_GR.UTF-8";
    LC_TELEPHONE = "el_GR.UTF-8";
    LC_TIME = "el_GR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
 
  # services.flatpak.enable = true;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us,gr";
    xkb.variant = "";
    xkb.options = "grp:alt_shift_toggle";
  };

  # sanity
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
  programs.nano.enable = false;
  
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

  # SERVICES
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  
  # BLUETOOTH
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # PIPEWIRE
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.john = {
    isNormalUser = true;
    description = "John Iliopoulos";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "libvirtd" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }]; 
    subGidRanges = [{ startGid = 100000; count = 65536; }];
    packages = with pkgs; [
    ];
  };

  # Home manager
  home-manager = {
   extraSpecialArgs = {inherit inputs;};
   users = {
      "john" = import ./home.nix;
   };
  };

  environment.shellAliases = {
  	#vim = "nvim";
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryPackage="qt";
  # };

  security.sudo.extraRules= [
  {  users = [ "john" ];
    commands = [
       { command = "ALL" ;
         options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
      }
    ];
  }];

  # AUTO UPDATES
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "daily";
    randomizedDelaySec = "45min";
  }; 
  # AUTO CLEANUP
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?


}
