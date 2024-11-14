{
  wrapGAppsHook4,
  gtk4,
  gobject-introspection,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "gtkSave";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [
    wrapGAppsHook4
    gobject-introspection
  ];

  buildInputs = [
    gtk4
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
  ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  postFixup = ''
    mv $out/bin/${pname}.py $out/bin/${pname}
  '';

}
