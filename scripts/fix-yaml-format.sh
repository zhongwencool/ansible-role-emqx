#!/bin/bash

# Function to fix YAML files
fix_yaml_file() {
    local file=$1
    # Remove trailing whitespace
    sed -i '' 's/[[:space:]]*$//' "$file"
    # Ensure single newline at end of file
    printf '%s\n' "$(cat "$file")" > "$file"
}

# Find and fix all YAML files
find . -type f \( -name "*.yml" -o -name "*.yaml" \) -not -path "./venv/*" -not -path "./.git/*" | while read -r file; do
    echo "Fixing $file..."
    fix_yaml_file "$file"
done

# Fix .yamllint file
if [ -f .yamllint ]; then
    echo "Fixing .yamllint..."
    fix_yaml_file .yamllint
fi

echo "YAML formatting completed!" 