{
  lib,
  buildNpmPackage,
  fetchzip,
  writableTmpDirAsHomeHook,
  versionCheckHook,
}:
buildNpmPackage (finalAttrs: {
  pname = "codex";
  version = "0.72.0";

  src = fetchzip {
    url = "https://registry.npmjs.org/@openai/codex/-/codex-${finalAttrs.version}.tgz";
    hash = "sha256-gt31kdIUxuiSgvaSm/PFenwfGud6uvxncAi6ABEJk/c=";
  };

  npmDepsHash = "sha256-4kCL/I3XEzHu/63S5y4KIvfrGcNTU7pN4xRmep3h23Y=";

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
    # npmInstallHook expects node_modules to exist, but this package doesn't
    # have any dependencies; create an empty directory so that this call to
    # find doesn't fail:
    #
    #     https://github.com/NixOS/nixpkgs/blob/cbfe00810c3b6c0e2d51205b7ac62a8fe5ac1174/pkgs/build-support/node/build-npm-package/hooks/npm-install-hook.sh#L37
    mkdir -p node_modules
  '';

  dontNpmBuild = true;

  doInstallCheck = true;
  nativeInstallCheckInputs = [versionCheckHook];

  meta = {
    description = "Lightweight coding agent that runs in your terminal";
    homepage = "https://github.com/openai/codex";
    license = lib.licenses.asl20;
    maintainers = [lib.maintainers.malo];
    mainProgram = "codex";
  };
})
