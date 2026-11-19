#!/usr/bin/env bash
# Installs the official Roslyn C# language server (the engine behind the
# VS Code C# extension) so nvim-lspconfig's `roslyn_ls` can find it on PATH.
#
# Usage: scripts/install-roslyn-ls.sh [version]
#   With no version the newest build on Microsoft's feed is used.
set -euo pipefail

FEED="https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/flat2"
INSTALL_ROOT="${ROSLYN_LS_HOME:-$HOME/.local/share/roslyn-ls}"
BIN_DIR="${ROSLYN_LS_BIN:-$HOME/.local/bin}"
BINARY="Microsoft.CodeAnalysis.LanguageServer"

case "$(uname -s)-$(uname -m)" in
    Darwin-arm64) PLATFORM="osx-arm64" ;;
    Darwin-x86_64) PLATFORM="osx-x64" ;;
    Linux-x86_64) PLATFORM="linux-x64" ;;
    Linux-aarch64) PLATFORM="linux-arm64" ;;
    *) echo "Unsupported platform: $(uname -s)-$(uname -m)" >&2; exit 1 ;;
esac

PACKAGE="microsoft.codeanalysis.languageserver.${PLATFORM}"

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
    VERSION="$(curl -fsSL "${FEED}/${PACKAGE}/index.json" | python3 -I -c '
import json, re, sys
versions = json.load(sys.stdin)["versions"]
def key(v):
    return [(0, int(p)) if p.isdigit() else (1, p) for p in re.split(r"[.-]", v)]
print(sorted(versions, key=key)[-1])
')"
fi

DEST="${INSTALL_ROOT}/${VERSION}"
NUPKG="${INSTALL_ROOT}/${PACKAGE}.${VERSION}.nupkg"

if [[ ! -x "${DEST}/${BINARY}" ]]; then
    echo "Downloading ${PACKAGE} ${VERSION}..."
    mkdir -p "$INSTALL_ROOT"
    curl -fL --progress-bar -o "$NUPKG" "${FEED}/${PACKAGE}/${VERSION}/${PACKAGE}.${VERSION}.nupkg"

    rm -rf "${DEST}.tmp"
    mkdir -p "${DEST}.tmp"
    unzip -q "$NUPKG" "content/LanguageServer/${PLATFORM}/*" -d "${DEST}.tmp"
    mv "${DEST}.tmp/content/LanguageServer/${PLATFORM}" "$DEST"
    rm -rf "${DEST}.tmp" "$NUPKG"
    chmod +x "${DEST}/${BINARY}"
else
    echo "${PACKAGE} ${VERSION} already installed."
fi

mkdir -p "$BIN_DIR"
ln -sfn "${DEST}/${BINARY}" "${BIN_DIR}/${BINARY}"
ln -sfn "$DEST" "${INSTALL_ROOT}/current"

echo "Installed ${BINARY} ${VERSION}"
echo "  server:  ${DEST}"
echo "  symlink: ${BIN_DIR}/${BINARY}"
