{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.callPackage ./default.nix { };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          ruff
        ];
        inputsFrom = [ self.packages.${system}.default ];
        shellHook = ''
          export XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH
        '';
      };
    };
}
