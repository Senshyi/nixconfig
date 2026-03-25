{ self, inputs, ...}: {

  flake.nixosModules.nixosConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.nixosHardware
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "janma"; # Define your hostname.

    networking.networkmanager.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    time.timeZone = "Europe/Prague";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "cs_CZ.UTF-8";
      LC_IDENTIFICATION = "cs_CZ.UTF-8";
      LC_MEASUREMENT = "cs_CZ.UTF-8";
      LC_MONETARY = "cs_CZ.UTF-8";
      LC_NAME = "cs_CZ.UTF-8";
      LC_NUMERIC = "cs_CZ.UTF-8";
      LC_PAPER = "cs_CZ.UTF-8";
      LC_TELEPHONE = "cs_CZ.UTF-8";
      LC_TIME = "cs_CZ.UTF-8";
    };

    services.xserver.enable = true;

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.gnome.core-developer-tools.enable = true;

    services.fstrim.enable = true;

    services.xserver.xkb = {
      layout = "us";
      options = "caps:escape";
    };

    services.printing.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users.janma = {
      isNormalUser = true;
      description = "janma";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    programs.firefox.enable = true;
    programs._1password.enable = true;
    programs._1password-gui.enable = true;

    nixpkgs.config.allowUnfree = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      hicolor-icon-theme
    ];

    system.stateVersion = "25.11";
  };
}
