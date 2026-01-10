{
  lib,
  buildNpmPackage,
  fetchzip,
  versionCheckHook,
}:
buildNpmPackage (finalAttrs: {
  pname = "pi-coding-agent";
  version = "0.42.4";

  src = fetchzip {
    url = "https://registry.npmjs.org/@mariozechner/pi-coding-agent/-/pi-coding-agent-${finalAttrs.version}.tgz";
    hash = "sha256-H8lCmLHFe2PUG8P7weN67tF8L7N4/IcOsI4DvGqjtTA=";
  };

  npmDepsHash = "sha256-ylZFNOnsc2RUuTLha6m5tS9FXvsVGIPlHbD5GvpyvvY=";

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  doInstallCheck = true;
  nativeInstallCheckInputs = [versionCheckHook];

  meta = {
    description = "Coding agent CLI with read, bash, edit, write tools and session management";
    homepage = "https://github.com/badlogic/pi-mono";
    license = lib.licenses.mit;
    mainProgram = "pi";
  };
})
