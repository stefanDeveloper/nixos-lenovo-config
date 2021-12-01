{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = builtins.toString (pkgs.writeText "rofi-theme" ''
      /**
      * Copyright: deadguy
      * (edited by Litarvan and Th0rgal)
      */
      configuration {
        display-drun:    "Activate";
        display-run:     "Execute";
        display-window:  "Window";
        show-icons:      true;
        sidebar-mode:    true;
        font: "JetbrainsMono Nerd Font 12";
      }
      * {
        background-color:            transparent;
        text-color:                  #b2aea8;
        selbg:                       #3949A3;
        actbg:                       #262626;
        urgbg:                       #e53935;
        winbg:                       #B3BEFF;
        selected-normal-foreground:  @winbg;
        normal-foreground:           @text-color;
        selected-normal-background:  @actbg;
        normal-background:           @background-color;
        selected-urgent-foreground:  @background-color;
        urgent-foreground:           @text-color;
        selected-urgent-background:  @urgbg;
        urgent-background:           @background-color;
        selected-active-foreground:  @winbg;
        active-foreground:           @text-color;
        selected-active-background:  @actbg;
        active-background:           @selbg;
        line-margin:                 2;
        line-padding:                2;
        separator-style:             "none";
        hide-scrollbar:              "true";
        margin:                      0;
        padding:                     0;
      }
      window {
        transparency: "real";
        background-color: #00000099;
        location:  north west;
        anchor:    north west;
        height:    50%;
        width:    20%;
        orientation:  horizontal;
        children:  [mainbox];
        x-offset:  29px;        
        y-offset:  57px;
      }
      mainbox {
        spacing:  0.8em;
        children: [entry, listview ];
      }
      button { padding: 5px 2px; }
      button selected {
        background-color: @active-background;
        text-color:       @background-color;
      }
      inputbar {
        padding: 5px;
        spacing: 5px;
      }
      listview {
        spacing: 0.5em;
        dynamic: false;
        cycle:   false;
      }
      element { padding: 10px; }
      entry {
        expand:         false;
        text-color:     @normal-foreground;
        vertical-align: 1;
        padding:        5px;
      }
      element normal.normal {
        background-color: @normal-background;
        text-color:       @normal-foreground;
      }
      element normal.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
      }
      element normal.active {
        background-color: @active-background;
        text-color:       @active-foreground;
      }
      element selected.normal {
        background-color: @selected-normal-background;
        text-color:       @selected-normal-foreground;
        border:           0 5px solid 0 0;
        border-color:      @active-background;
      }
      element selected.urgent {
        background-color: @selected-urgent-background;
        text-color:       @selected-urgent-foreground;
      }
      element selected.active {
        background-color: @selected-active-background;
        text-color:       @selected-active-foreground;
      }
      element alternate.normal {
        background-color: @normal-background;
        text-color:       @normal-foreground;
      }
      element alternate.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
      }
      element alternate.active {
        background-color: @active-background;
        text-color:       @active-foreground;
      }
    '');
  };
}