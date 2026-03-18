#!/bin/bash

# Check for AIRTABLE_API_KEY
if [ -z "$AIRTABLE_API_KEY" ]; then
    echo "Error: AIRTABLE_API_KEY environment variable is not set"
    exit 1
fi

PLACEHOLDER="--key-will-go-here--"
CONFIG_FILE="ssotme.json"

# Insert the API key
sed -i.bak "s|$PLACEHOLDER|$AIRTABLE_API_KEY|g" "$CONFIG_FILE"

# Run the build
effortless build
BUILD_EXIT_CODE=$?

# Restore the placeholder
sed -i.bak "s|$AIRTABLE_API_KEY|$PLACEHOLDER|g" "$CONFIG_FILE"

# Clean up backup file
rm -f "$CONFIG_FILE.bak"

exit $BUILD_EXIT_CODE
