# Development Agents – Guidelines

## Mandatory Testing

Every time a change is made to the code (feature, bug fix, refactoring…), **you must run the tests** to ensure the stability of the project.

Before running the tests, you must also run static analysis.

### How to run the tests

1. Make sure all dependencies are installed:

   ```bash
   flutter pub get
   ```
2. Run the analyzer to check for any issues:

   ```bash
   flutter analyze
   ```
3. Run the tests:

   ```bash
   flutter test
   ```
