# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.hostName = "bonkymini"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bonky = {
    isNormalUser = true;
    group = "users";
    shell = pkgs.zsh;
    createHome = true;
    home = "/home/bonky";
    extraGroups = [ "wheel" "libvirtd" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVAQElq6Xb2QnucMspGF1bTlg76XUaNuYQ6y+Tk+REG02+F0sO1KRHzURViD/FLLfkxmBlkhZ3TBtYfb6Ft74NK+l3Yhn+Ghm237IU7OVARw9xHIYLox3lGzAyGm+Fr34W3oCY4VkknmGC0cf90Joa1wb+Yn6YRnblDPqF3BSJylanKbi6kYhiaQeCbRtrfaEjycVFdL9iK5EqJZRIAHAMvg6L1eRY9mPCjZv9DbOPlWOihDZup2u6sAX7+E5XfzelXavEwJ9UMDJPCHBtSz9Y8WgLgjrslUOpqUgIiP0GCSWtt9w7dbDqphS10Vt9byb3osf9UrtaAnx4xp/h/7yINQSyACPKyD/+pH5qSzUvh5FWFxIHwbG08F3K+EOkjOlEU6v0ilEiAMULAKWmX9WNkh3bIWsokJIxIvTNB4k4kUOyhyVBghi29TooRb95698NPAVD5Ss5363dRgvvpxIJXLmyV3IDqsC9cVk+kuxhCpYABd6FAORYCBIHmzPBDDF6X9Rs6lTx5fB7QD73XnMmJbjCYHU/RZPC0ZIQ4tvGnUIgHwBuR9N/ZzdSuUmUWt9ZZXdLDlIG/DY2co+53thc3WEkrlL451f460iXXGEZ5EGuVs2vKcs4E1h3B727x2R0ufFiW54mb3LO180bt41EykN0Nlpa93KACr7ah6gMhQ=="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDNKozYeb+GobsLEhdPOoUTyXZDbwIYKsSVlGRHXo1mJ"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB01E0rVw7dyUWZzQ1D6HpR2A2CKLetHjnUeTR6kyGsp"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZD1EHjnuXdj0dKKAlF5OLyzfZSorHiAMcfRlUWEVGo"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfl69KlX20c0gy1QVVWHhtHhJxuv8cbxj36zj6VzxW0"
    ];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # base
    git
    home-manager
    vim
    wget
    zsh

    # virtualization
    virt-manager

    # networking
    tailscale
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  services.tailscale.enable = true;

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;
    };
    oci-containers.containers = {
     whoami = {
       image = "containous/whoami";
       ports = ["127.0.0.1:8080:80"];
     };
  };
  };

  # Use libvirtd for managing virtual machines.
  # This only enables the service, but does not add users to the libvirt group.
  virtualisation.libvirtd.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.bonky = { pkgs, ... }: {
    programs.home-manager.enable = true;
  };
  #

  programs.zsh.enable = true;
}

