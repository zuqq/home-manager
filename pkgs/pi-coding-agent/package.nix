{
  lib,
  buildNpmPackage,
  fetchzip,
  runCommand,
  jq,
}:
buildNpmPackage (finalAttrs: let
  shrinkwrapPatch = builtins.readFile ./shrinkwrap-patch.json;

  patches = runCommand "pi-coding-agent-patches" {
    inherit (finalAttrs) src;
    nativeBuildInputs = [jq];
  } ''
    mkdir -p $out
    # Add @earendil-works/* packages that are missing from the shrinkwrap.
    jq --argjson patch ${lib.escapeShellArg shrinkwrapPatch} '$patch * .' "$src/npm-shrinkwrap.json" >$out/package-lock.json
    # The shrinkwrap is generated with `--omit=dev`, so we need to also omit
    # development dependencies here.
    jq 'del(.devDependencies)' "$src/package.json" >$out/package.json
  '';
in {
  pname = "pi-coding-agent";
  version = "0.79.10";

  src = fetchzip {
    url = "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-${finalAttrs.version}.tgz";
    hash = "sha256-n4bd83Y3d5wpm13Z2djHTRL+8miF9F5wR0BhCkXKP/U=";
  };

  npmDepsHash = "sha256-0VLk4UQ2GWoKVzSoHXdnC5aKQrsRyS2R8PhBlWGo7oo=";

  postPatch = ''
    rm -f npm-shrinkwrap.json
    cp ${patches}/package-lock.json package-lock.json
    cp ${patches}/package.json package.json
  '';

  dontNpmBuild = true;

  meta = {
    description = "Coding agent CLI with read, bash, edit, write tools and session management";
    homepage = "https://github.com/earendil-works/pi-mono";
    license = lib.licenses.mit;
    mainProgram = "pi";
  };
})
