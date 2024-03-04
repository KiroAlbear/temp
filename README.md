# Dokkan

## Setting Up the Project

### Prerequisites

Ensure you have Dart and Flutter installed on your system. You can download and install them from the official [Dart](https://dart.dev/get-dart) and [Flutter](https://flutter.dev/docs/get-started/install) websites.

### Direct to native android file

```bash
cd android
```

### Start Sync Android Project

```bash
./gradlew syncDebugLibJars
```
### Activating Melos

To begin, activate Melos globally with version 2.9.0:

```bash
dart pub global activate melos 2.9.0
```

### Bootstrap the Project

Enable Bootstrap using Melos:

```bash
melos bootstrap
```

### Building the Project

To build the project, use the following commands:

1. **Update Dependencies:**

   ```bash
   melos exec -- flutter pub get
   ```

2. **Clean the Project:**

   ```bash
   melos exec -- flutter clean
   ```

3. **Generate Files for All Packages:**

   ```bash
   melos exec -- dart run build_runner build --delete-conflicting-outputs
   ```

## Building Custom Plugins

### Building Custom Plugins for Packages

Navigate to the package directory and run the following command to build the custom plugin:

```bash
cd package_name
dart run build_runner build --delete-conflicting-outputs
```

## Running the Application

### Running Tests

To run tests for the test environment, use:

```bash
flutter run --flavor app_test lib/main_app_test.dart
```

### Running in Staging Environment

To run in the staging environment, use:

```bash
flutter run --flavor app_stage lib/main_app_stage.dart
```

### Running in Live Environment

To run in the live environment, use:

```bash
flutter run --flavor app_live lib/main_app_live.dart
```

### Building Flavors in the Application

To build flavors in the application, follow these steps:

1. **Copy the Following Files:**
    - `flavors.dart`
    - `main.dart`
    - `main_app_live.dart`
    - `main_app_stage.dart`
    - `main_app_test.dart`

2. **Run the Flutter Flavorizr Command:**

   ```bash
   flutter pub run flutter_flavorizr
   ```

3. **Replace Old Files with New Files:**
    - Replace `flavors.dart`, `main.dart`, `main_app_live.dart`, `main_app_stage.dart`, and `main_app_test.dart` with the newly generated files.

4. **Remove Unnecessary Files:**
    - Remove `app.dart` and the package called `pages` if they exist in the project.

## Custom Commands

If you need to run custom commands with Flutter or Dart, use the following Melos command:

```bash
melos exec -- your_command_here
```

Feel free to modify these instructions according to your specific project requirements.


### Build APK

## Build Test APK
```bash
flutter build apk --release --flavor app_test lib/main_app_test.dart
```

## Build Stage APK

```bash
flutter build apk --release --flavor app_stage lib/main_app_stage.dart
```

## Build Stage APK

```bash
flutter build apk --release--flavor app_live lib/main_app_live.dart
```