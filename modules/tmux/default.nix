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
    (writeShellApplication {
      name = "clean-tmux";
      text = /*zsh*/ ''
        if [ -n "$TMUX" ]; then
          for window in $(tmux lsw -F "#{window_id}"); do
            for pane in $(tmux lsp -t "$window" -F "#{pane_id}"); do
              tmux if-shell -t "$pane" -F "#{==:#{pane_mode},copy-mode}" "send-keys -X -t $pane cancel"
              tmux send-keys -t "$pane" "c-l"
              tmux clear-history -t "$pane"
            done
          done
        fi
      '';
      runtimeInputs = [ tmux ];
    })
  ];
}
