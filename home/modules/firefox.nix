{
  lib,
  config,
  pkgs,
  ...
}:

{
  config.programs.firefox.enable = true;
  config.programs.firefox.profiles."default-release" = {
    id = 0;
    path = "default";
    isDefault = true;

    settings = {
      "layout.css.devPixelsPerPx" = 0.9;
      "browser.aboutwelcome.enabled" = false;
      "extensions.autoDisableScopes" = 0;
      "ui.key.menuAccessKeyFocuses" = false;
      "browser.startup.page" = 1;
      "browser.aboutConfig.showWarning" = false;
      "browser.tabs.closeWindowWithLastTab" = false;
      "browser.tabs.fadeOutUnloadedTabs" = true;
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "solid-color-picker-#171717";
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "sidebar.visibility" = "always";
      "sidebar.expandOnHover" = false;
      "sidebar.verticalTabs" = true;
      "sidebar.position_start" = false; # Move to right
      # "sidebar.animation.expand-on-hover.duration-ms" = 66;
      # "sidebar.main.tools" = "syncedtabs,history,bookmarks";
      "sidebar.main.tools" = "";
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.uiCustomization.state" = {
        "placements" = {
          "nav-bar" = [
            # "sidebar-button"
            "back-button"
            "forward-button"
            "stop-reload-button"
            "customizableui-special-spring1"
            "vertical-spacer"
            "urlbar-container"
            "personal-bookmarks"
            "customizableui-special-spring2"
            "downloads-button"
            "unified-extensions-button"
            "fxa-toolbar-menu-button"
          ];
          "toolbar-menubar" = [ "menubar-items" ];
          "vertical-tabs" = [ "tabbrowser-tabs" ];
          # "PersonalToolbar" = [ "personal-bookmarks" ];
        };
        "currentVersion" = 22;
        "newElementCount" = 5;
      };
      "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
      "devtools.debugger.remote-enabled" = true;
      "devtools.chrome.enabled" = true;
    };

    # non-clickable "mute/unmute" playback buttons on background tabs
    userChrome = ''
      tab.tabbrowser-tab:not([selected="true"]) image.tab-icon-overlay[role="presentation"] {
        pointer-events: none;
      }
    '';

    containersForce = true;
  };
 }
