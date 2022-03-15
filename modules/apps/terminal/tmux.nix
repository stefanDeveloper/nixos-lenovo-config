{ pkgs, inputs, ... }:

{
  home-manager.users.stefan.programs.tmux = {
    enable = true;

    shortcut = "a";
    aggressiveResize = true;
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    historyLimit = 10000;

    keyMode = "vi";

    extraConfig = ''
      # Renumber windows sequentially after closing any of them
      set -g renumber-windows on

      # Place status on top
      set-option -g status-position top

      # Automatically set window title
      setw -g automatic-rename

      # Titles (window number, program name, active (or not)
      set -g set-titles on
      set -g set-titles-string '#H:#S.#I.#P #W #T'

      # Automatically set window title
      setw -g automatic-rename
      
      # Status bar
      set -g status-interval 2

      # Enable mouse
      set -g mouse on

      # Pane resize in all four directions using vi bindings.
      # can use these raw but I map them to shift-ctrl-<h,j,k,l> in iTerm.
      bind-key J resize-pane -D 12
      bind-key K resize-pane -U 12
      bind-key H resize-pane -L 14
      bind-key L resize-pane -R 14

      # Quick pane cycling
      unbind ^S
      bind ^S select-pane -t:.+

      # Switching between sessions
      unbind ^A
      bind ^A choose-tree

      # Easily toggle synchronization (mnemonic: e is for echo)
      # sends input to all panes in a given window
      bind e setw synchronize-panes on
      bind E setw synchronize-panes off

      # Set first window and pane to index 1 (not 0)
      # to map more to the keyboard layout
      set -g base-index 1
      set -g pane-base-index 1

      # Vi style copy&paste
      bind Space copy-mode
      bind C-Space copy-mode

      unbind p
      bind p paste-buffer

      # Setup 'v' to begin selection as in Vim
      bind-key -Tcopy-mode-vi 'v' send -X begin-selection
      bind-key -Tcopy-mode-vi 'y' send -X copy-pipe-and-cancel pbcopy
      bind-key -Tcopy-mode-vi Escape send -X cancel
      bind-key -Tcopy-mode-vi V send -X rectangle-toggle

      # Vim-style navigation between panes
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Activity monitoring
      setw -g monitor-activity on
      set -g visual-activity off

      # Horizontal and vertical splits
      bind j split-window -v
      bind l split-window -h

      # Killing window/pane
      bind-key q kill-window
      bind-key x kill-pane

      # Maximize active pane with h or ctrl+h
      bind h resize-pane -Z
      bind C-h resize-pane -Z

      # Disable arrow navigation
      unbind Right
      unbind Left
      unbind Up
      unbind Down

      # Precise pane resizing
      bind Right resize-pane -R 8
      bind Left resize-pane -L 8
      bind Up resize-pane -U 8
      bind Down resize-pane -D 8

      # Rebind prefix
      unbind C-b
      set -g prefix C-Space
      bind Space send-prefix

      # Restore screen clearing
      bind C-l send-keys 'C-l'

      # Layout
      unbind =
      bind = select-layout tiled

      # Switching between layouts
      bind o select-layout "active-only"
      bind - select-layout "even-vertical"
      bind | select-layout "even-horizontal"
      bind r rotate-window
    '';

    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      
    ];
  };
}
