{ pkgs, inputs }:

pkgs.php.buildComposerProject (finalAttrs: {
  pname = "phpactor";
  version = "master";
  src = inputs.phpactor-laravel;
  vendorHash = "sha256-A6IvZwbw7v3kzr5DCAXABkBOwePMTE0vctyhpmEPBgA=";
  buildInputs = [ pkgs.php84 ];
})

