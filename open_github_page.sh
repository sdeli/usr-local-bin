STAMM="$(git config --get remote.origin.url | sed 's/\.git//g')"
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
open "${STAMM}"/tree/"${BRANCH_NAME}"