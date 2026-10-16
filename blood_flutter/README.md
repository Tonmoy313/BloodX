# blood_flutter

A new Flutter project with Serverpod.

> [!NOTE]
> **Android Build & Toolchain Requirements (Java 25 / Gradle 9.x)**
> - **Java Version**: Compatible with **Java 25** (e.g., Android Studio JBR `25.0.2`).
> - **Gradle**: `9.8.1` (configured in `android/gradle/wrapper/gradle-wrapper.properties`).
> - **AGP & Kotlin**: AGP `9.0.0` and Kotlin `2.1.0` (in `android/settings.gradle.kts`).
> - **Compatibility Flags**: `android.builtInKotlin=false` and `android.newDsl=false` in `android/gradle.properties` (required by Flutter plugins on AGP 9).
> - **Plugin Order**: In `android/app/build.gradle.kts`, `id("kotlin-android")` must be applied before `id("dev.flutter.flutter-gradle-plugin")`.


## Getting Started

This project is a starting point for a Flutter application that is using
Serverpod.

A great starting point for learning Serverpod is our documentation site at:
[https://docs.serverpod.dev](https://docs.serverpod.dev).

To run the project, first make sure that the server is running, then do:

    flutter run
