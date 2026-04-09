{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = prefix-highlight;
        extraConfig = builtins.readFile ./status.tmux.conf;
      }
      {
        plugin = resurrect;
        extraConfig = builtins.readFile ./resurrect.tmux.conf;
      }
    ];
    extraConfig = builtins.readFile ./before-plugins.tmux.conf;
  };

  home.packages = with pkgs; [
    (writeShellApplication {
      name = "show-tmux-popup";
      text = builtins.readFile ./show-tmux-popup.sh;
      runtimeInputs = [ tmux ];
    })
  ];
}
