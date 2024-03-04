{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    # General
    fastfetch
    neovim
    gitFull 
    wget
    qbittorrent
    backintime
    firefox
    brave
    direnv
    vscode-fhs
    haruna
    ffmpeg
    yt-dlp
    krita
    psmisc
    # Go
    go
    gopls
  ];
}