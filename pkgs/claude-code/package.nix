{
  lib,
  stdenvNoCC,
  fetchurl,
  installShellFiles,
  makeBinaryWrapper,
  procps,
  ripgrep,
  versionCheckHook,
  writableTmpDirAsHomeHook,
}:
let
  stdenv = stdenvNoCC;
  baseUrl = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases";
  manifest = lib.importJSON ./manifest.json;
  platformKey = "darwin-arm64";
  platformManifestEntry = manifest.platforms.${platformKey};
in
stdenv.mkDerivation (finalAttrs: {
  pname = "claude-code";
  inherit (manifest) version;

  src = fetchurl {
    url = "${baseUrl}/${finalAttrs.version}/${platformKey}/claude";
    sha256 = platformManifestEntry.checksum;
  };

  dontUnpack = true;
  dontBuild = true;
  # Darwin needs sandbox bypass during install (matches upstream).
  __noChroot = true;
  # Stripping would corrupt the Bun runtime appended to the binary.
  dontStrip = true;

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ];

  strictDeps = true;

  installPhase = ''
    runHook preInstall

    installBin $src

    wrapProgram $out/bin/claude \
      --set DISABLE_AUTOUPDATER 1 \
      --set-default FORCE_AUTOUPDATE_PLUGINS 1 \
      --set DISABLE_INSTALLATION_CHECKS 1 \
      --set USE_BUILTIN_RIPGREP 0 \
      --prefix PATH : ${
        lib.makeBinPath [
          # node-tree-kill (used by claude-code) needs pgrep on darwin
          procps
          # https://code.claude.com/docs/en/troubleshooting#search-and-discovery-issues
          ripgrep
        ]
      }

    runHook postInstall
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    writableTmpDirAsHomeHook
    versionCheckHook
  ];
  versionCheckKeepEnvironment = ["HOME"];
  versionCheckProgramArg = "--version";
  # versionCheckHook in 25.05 defaults to bin/$pname; we want bin/claude.
  versionCheckProgram = "${placeholder "out"}/bin/claude";

  passthru.updateScript = ./update.sh;

  meta = {
    description = "Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster";
    homepage = "https://github.com/anthropics/claude-code";
    downloadPage = "https://claude.com/product/claude-code";
    changelog = "https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    platforms = ["aarch64-darwin"];
    mainProgram = "claude";
  };
})
