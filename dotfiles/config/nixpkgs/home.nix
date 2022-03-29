{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bonky";
  home.homeDirectory = "/home/bonky";

  home.packages = [
    # core
    pkgs.git
    pkgs.zsh

    # rust bin scripts
    pkgs.exa pkgs.bat pkgs.starship

    # docker
    pkgs.docker-compose

    # k8s
    pkgs.kubectl
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "Michael Bianchi";
    userEmail = "michael@bianchi.dev";
  }
}
