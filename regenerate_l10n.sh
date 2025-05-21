#!/bin/bash -e
echo "Running flutter pub get..."
flutter pub get

echo "Running flutter gen-l10n..."
if ! flutter gen-l10n; then
  echo "Error: Failed to generate localization files"
  exit 1
fi

echo "Running build_runner..."
flutter pub run build_runner build --delete-conflicting-outputs

echo "Done!"