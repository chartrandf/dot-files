# Goal: Ability to run Prettier on a batch of files without configuring the entire project.

if ! prettier_loc="$(type -p "prettier")" || [[ -z $prettier_loc ]]; then
  npm install -g prettier
fi

if [ $# -eq 0 ]; then
  echo "No files path(s) have been passed. Exiting."
  exit 1  # Exit with a non-zero status code to indicate an error.
fi

script_dir=$(dirname "$0")
config_file="$script_dir/.prettierrc"

set -x
prettier "$@" --config "$config_file" --write
