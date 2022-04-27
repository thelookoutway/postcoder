let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources.nixpkgs {};
  mkBundlerAppDevShell = nixpkgs.callPackage (import sources.bundler-app-dev-shell) {};
in mkBundlerAppDevShell {
  buildInputs = with nixpkgs; [
    heroku
    libiconv
    pkg-config
    ruby_3_1
    zlib
  ];
}
