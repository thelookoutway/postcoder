let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources."nixpkgs" {};

  # Ruby 2.6.6
  ruby = nixpkgs.ruby_2_6;

  # Bundler 2.1.4
  bundler = nixpkgs.bundler.override { ruby = ruby; };

  environment = nixpkgs.stdenv.mkDerivation {
    name = "environment";
    phases = [ "installPhase" "fixupPhase" ];
    installPhase = ''
      touch $out
    '';
    buildInputs = [
      ruby
      bundler

      nixpkgs.heroku
      nixpkgs.libiconv
      nixpkgs.pkg-config
      nixpkgs.zlib
    ];
  };
in
nixpkgs.mkShell {
  buildInputs = environment.drvAttrs.buildInputs;
  shellHook =
    let
      # We use the store-path for environment as our Bundler cache-key to rebuild gems when the environment changes
      environmentId = nixpkgs.lib.last (nixpkgs.lib.strings.splitString "/" "${environment}");

    in ''
      if [ -z "$BUNDLE_PATH" ]; then
        export BUNDLE_PATH=.bundle/${environmentId}
      else
        export BUNDLE_PATH=$BUNDLE_PATH/${environmentId}
      fi
    '';
}
