{
  lib,
  buildNpmPackage,
  fetchzip,
  versionCheckHook,
}:
buildNpmPackage (finalAttrs: {
  pname = "pi-coding-agent";
  version = "0.74.0";

  src = fetchzip {
    url = "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-${finalAttrs.version}.tgz";
    hash = "sha256-I6urHVoMvZzz3I4y067gYGacIPPgYnZ/uDgw1o0A5Ks=";
  };

  npmDepsHash = "sha256-GiTmVzlHZoZ3x3FOhByDPfesepmfkOc7l9DzwURKBps=";

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  doInstallCheck = true;
  nativeInstallCheckInputs = [versionCheckHook];

  meta = {
    description = "Coding agent CLI with read, bash, edit, write tools and session management";
    homepage = "https://github.com/earendil-works/pi-mono";
    license = lib.licenses.mit;
    mainProgram = "pi";
  };
})
