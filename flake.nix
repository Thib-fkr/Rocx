{
  description = "Build and expose the tree-sitter grammar for the roc language.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tree-sitter-roc = {
      url = "github:faldor20/tree-sitter-roc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      flake-utils,
      tree-sitter-roc,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = rec {
          queries = tree-sitter-roc.packages.${system}.default;
          shared_obj = pkgs.stdenv.mkDerivation {

            name = "roc_so_builder";

            src = tree-sitter-roc;

            buildInputs = [
              pkgs.gcc
            ];

            buildPhase = ''
              runHook preBuild

              make

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall

              mkdir -p $out/shared_obj
              mkdir -p $out/queries

              cp *.so $out/shared_obj
              cp queries/* $out/queries

              runHook postInstall
            '';
          };

          default = shared_obj;
        };
      }
    );
}
