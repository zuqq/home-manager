{
  lib,
  buildNpmPackage,
  fetchzip,
  versionCheckHook,
}:
buildNpmPackage (finalAttrs: {
  pname = "pi-coding-agent";
  version = "0.52.12";

  src = fetchzip {
    url = "https://registry.npmjs.org/@mariozechner/pi-coding-agent/-/pi-coding-agent-${finalAttrs.version}.tgz";
    hash = "sha256-iS4nVZvLefliCdinNXf1RWmfiipM/rquvdIlNwyF5LE=";
  };

  npmDepsHash = "sha256-zf+CPw95dQosPd07iQ4ZiMQ47IkiU0ivMiUkY/XKCpQ=";

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
