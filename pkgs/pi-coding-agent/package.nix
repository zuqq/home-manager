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
  version = "0.75.5";

  src = fetchzip {
    url = "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-${finalAttrs.version}.tgz";
    hash = "sha256-oZIzs+txiowbC1wkb3u8yIsXj/RU8snrlsWX8q2zq84=";
  };

  npmDepsHash = "sha256-qZcRymrhE2DgTQJDSELNYCwh1lM5UG/LIaFydCSKv8Q=";

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
