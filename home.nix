{ pkgs, ... }:
{
  imports = [
    ./programs
    #./nvim
    ./services
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Materia";
    };

    iconTheme = {
      package = pkgs.numix-icon-theme-circle;
      name = "Numix-Circle";
    };
  };

  xsession.enable = true;

  xsession.pointerCursor = {
    package = pkgs.nur.repos.ambroisie.vimix-cursors;
    name = "Vimix-white-cursors";
    size = 38;
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bitwarden
    # calibre
    tree
    element-desktop
    qbittorrent
    nur.repos.ilya-fedin.kotatogram-desktop
    latest.firefox-nightly-bin
    # Game
    polymc
    factorio

    # Music & Video
    spotify
    spotify-tui
    spotifyd
    sptlrx
    playerctl
    cava
    vlc
    obs-studio

    # Application
    nur.repos.linyinfeng.icalingua-plus-plus
    nur.repos.linyinfeng.wemeet
    discord
    screenkey
  ];
  home.stateVersion = "21.11";
}
