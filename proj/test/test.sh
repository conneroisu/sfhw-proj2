
parent_path=$( cd "$(dirname "$0")" ; pwd -P )
echo "parent_path: $parent_path"
# split to the last '/'
last_slash=$(echo "$parent_path" | rev | cut -d'/' -f1 | rev)
echo "last_slash: $last_slash"
