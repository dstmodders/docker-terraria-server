#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMIT_ID=$(git rev-parse --verify HEAD)
JSON="$(cat ./versions.json)"
OFFICIAL_VERSIONS_KEYS=()
REPOSITORY='https://github.com/dstmodders/docker-terraria-server'
TSHOCK_VERSIONS_KEYS=()

mapfile -t OFFICIAL_VERSIONS_KEYS < <(jq -r '.official | keys[]' <<< "${JSON}")
# shellcheck disable=SC2207
IFS=$'\n' OFFICIAL_VERSIONS_KEYS=($(sort -rV <<< "${OFFICIAL_VERSIONS_KEYS[*]}")); unset IFS

mapfile -t TSHOCK_VERSIONS_KEYS < <(jq -r '.tshock | keys[]' <<< "${JSON}")
# shellcheck disable=SC2207
IFS=$'\n' TSHOCK_VERSIONS_KEYS=($(sort -rV <<< "${TSHOCK_VERSIONS_KEYS[*]}")); unset IFS

readonly BASE_DIR
readonly COMMIT_ID
readonly OFFICIAL_VERSIONS_KEYS
readonly REPOSITORY
readonly TSHOCK_VERSIONS_KEYS

# https://stackoverflow.com/a/17841619
function join_by {
  local d="${1-}"
  local f="${2-}"
  if shift 2; then
    printf %s "$f" "${@/#/$d}";
  fi
}

function jq_value {
  local from="$1"
  local key="$2"
  local name="$3"
  jq -r ".[${key}] | .${name}" "${from}"
}

function print_url() {
  local tags="$1"
  local commit="$2"
  local directory="$3"
  local url="[$tags](${REPOSITORY}/blob/${commit}/${directory}/Dockerfile)"
  echo "- ${url}"
}

cd "${BASE_DIR}" || exit 1

printf "## Supported tags and respective \`Dockerfile\` links\n\n"

# reference: 1.4.4.9-official, 1.4.4.9, official, latest
for key in "${OFFICIAL_VERSIONS_KEYS[@]}"; do
  commit="${COMMIT_ID}"
  terraria_version=$(jq -r ".official | .[${key}] | .terraria_version" <<< "${JSON}")
  terraria_latest=$(jq -r ".official | .[${key}] | .terraria_latest" <<< "${JSON}")

  tags="\`${terraria_version}-official\`, \`${terraria_version}\`"

  if [ "${terraria_latest}" == 'true' ]; then
    tags="${tags}, \`official\`, \`latest\`"
  fi

  print_url "${tags}" "${commit}" 'official'
done

# reference: 1.4.4.9-tshock-5.2.0, 1.4.4.9-tshock, tshock-5.2.0, 5.2.0, tshock
for key in "${TSHOCK_VERSIONS_KEYS[@]}"; do
  commit="${COMMIT_ID}"
  terraria_version=$(jq -r ".tshock | .[${key}] | .terraria_version" <<< "${JSON}")
  terraria_latest=$(jq -r ".tshock | .[${key}] | .terraria_latest" <<< "${JSON}")
  tshock_version=$(jq -r ".tshock | .[${key}] | .tshock_version" <<< "${JSON}")
  tshock_latest=$(jq -r ".tshock | .[${key}] | .tshock_latest" <<< "${JSON}")

  tags="\`${terraria_version}-tshock-${tshock_version}\`"

  if [ "${tshock_latest}" == 'true' ]; then
    tags="${tags}, \`${terraria_version}-tshock\`"
  fi

  if [ "${terraria_latest}" == 'true' ]; then
    tags="${tags}, \`tshock-${tshock_version}\`, \`${tshock_version}\`"
  fi

  if [ "${terraria_latest}" == 'true' ] && [ "${tshock_latest}" == 'true' ]; then
    tags="${tags}, \`tshock\`"
  fi

  print_url "${tags}" "${commit}" 'tshock'
done
