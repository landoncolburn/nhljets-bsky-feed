#!/bin/bash

# Input file containing the list of URLs (one URL per line)
INPUT_FILE="urls.txt"

# Output CSV file
OUTPUT_FILE="results.csv"

# Write the header to the CSV file
echo "URL,Result" > "$OUTPUT_FILE"

# Read each URL from the input file
# Read each URL from the input file
while IFS= read -r url; do
  if [[ -n "$url" ]]; then
    # Curl the URL and capture the response text
    content=$(curl -s "$url")

    # Escape commas and newlines in the content for CSV compatibility
    escaped_content=$(echo "$content" | tr '\n' ' ' | sed 's/,/\\,/g')

    # Escape commas in the URL
    escaped_url=$(echo "$url" | sed 's/,/\\,/g')

    # Append the URL and content to the CSV file
    echo "$escaped_url,\"$escaped_content\"" >> "$OUTPUT_FILE"
  fi
done < "$INPUT_FILE"

echo "Results saved to $OUTPUT_FILE"
