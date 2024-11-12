with import <nixpkgs> { };
mkShell {
  packages = [
    python3
    ruff
    gtk4
    gobject-introspection
    libadwaita
    gsettings-desktop-schemas
    (with python3Packages; [
      pygobject3
    ])
  ];
  shellHook = ''
    export XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH
  '';
}
