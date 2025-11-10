#!/usr/bin/env bash
# Initialize spec-kit workspace structure
# Run this once when the workflow is first activated to set up shared artifacts

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOW_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

echo "Initializing spec-kit workspace..."

# Create symlink from specs/ to shared artifacts/specs/
SPECS_LINK="$WORKFLOW_ROOT/specs"
ARTIFACTS_SPECS="$WORKFLOW_ROOT/../../artifacts/specs"

if [ -e "$SPECS_LINK" ]; then
    echo "✓ specs/ already exists"
else
    # Ensure target directory exists
    mkdir -p "$ARTIFACTS_SPECS"
    
    # Create symlink
    ln -s "$ARTIFACTS_SPECS" "$SPECS_LINK"
    echo "✓ Created specs → ../../artifacts/specs symlink"
fi

# Add to .gitignore if not already there
GITIGNORE="$WORKFLOW_ROOT/.gitignore"
if [ -f "$GITIGNORE" ] && grep -q "^specs$" "$GITIGNORE" 2>/dev/null; then
    echo "✓ specs/ already in .gitignore"
elif [ -f "$GITIGNORE" ]; then
    echo "specs" >> "$GITIGNORE"
    echo "✓ Added specs/ to .gitignore"
else
    echo "specs" > "$GITIGNORE"
    echo "✓ Created .gitignore with specs/"
fi

echo ""
echo "✅ Workspace initialized successfully!"
echo ""
echo "Next steps:"
echo "  • Use /speckit.specify to create a new feature specification"
echo "  • Specs will be stored in the shared artifacts/specs/ directory"
echo "  • This directory persists across workflow switches"

