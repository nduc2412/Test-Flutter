[33mcommit 1445b133740b389460e1d4a1a46942b8124cd35a[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m)[m
Author: Nguyen Duc <nduc85200@gmail.com>
Date:   Wed Nov 5 21:02:50 2025 +0700

    my first commit and first time use git

[1mdiff --git a/.gitignore b/.gitignore[m
[1mnew file mode 100644[m
[1mindex 0000000..3820a95[m
[1m--- /dev/null[m
[1m+++ b/.gitignore[m
[36m@@ -0,0 +1,45 @@[m
[32m+[m[32m# Miscellaneous[m
[32m+[m[32m*.class[m
[32m+[m[32m*.log[m
[32m+[m[32m*.pyc[m
[32m+[m[32m*.swp[m
[32m+[m[32m.DS_Store[m
[32m+[m[32m.atom/[m
[32m+[m[32m.build/[m
[32m+[m[32m.buildlog/[m
[32m+[m[32m.history[m
[32m+[m[32m.svn/[m
[32m+[m[32m.swiftpm/[m
[32m+[m[32mmigrate_working_dir/[m
[32m+[m
[32m+[m[32m# IntelliJ related[m
[32m+[m[32m*.iml[m
[32m+[m[32m*.ipr[m
[32m+[m[32m*.iws[m
[32m+[m[32m.idea/[m
[32m+[m
[32m+[m[32m# The .vscode folder contains launch configuration and tasks you configure in[m
[32m+[m[32m# VS Code which you may wish to be included in version control, so this line[m
[32m+[m[32m# is commented out by default.[m
[32m+[m[32m#.vscode/[m
[32m+[m
[32m+[m[32m# Flutter/Dart/Pub related[m
[32m+[m[32m**/doc/api/[m
[32m+[m[32m**/ios/Flutter/.last_build_id[m
[32m+[m[32m.dart_tool/[m
[32m+[m[32m.flutter-plugins-dependencies[m
[32m+[m[32m.pub-cache/[m
[32m+[m[32m.pub/[m
[32m+[m[32m/build/[m
[32m+[m[32m/coverage/[m
[32m+[m
[32m+[m[32m# Symbolication related[m
[32m+[m[32mapp.*.symbols[m
[32m+[m
[32m+[m[32m# Obfuscation related[m
[32m+[m[32mapp.*.map.json[m
[32m+[m
[32m+[m[32m# Android Studio will place build artifacts here[m
[32m+[m[32m/android/app/debug[m
[32m+[m[32m/android/app/profile[m
[32m+[m[32m/android/app/release[m
[1mdiff --git a/.metadata b/.metadata[m
[1mnew file mode 100644[m
[1mindex 0000000..70a7d44[m
[1m--- /dev/null[m
[1m+++ b/.metadata[m
[36m@@ -0,0 +1,45 @@[m
[32m+[m[32m# This file tracks properties of this Flutter project.[m
[32m+[m[32m# Used by Flutter tool to assess capabilities and perform upgrades etc.[m
[32m+[m[32m#[m
[32m+[m[32m# This file should be version controlled and should not be manually edited.[m
[32m+[m
[32m+[m[32mversion:[m
[32m+[m[32m  revision: "9f455d2486bcb28cad87b062475f42edc959f636"[m
[32m+[m[32m  channel: "stable"[m
[32m+[m
[32m+[m[32mproject_type: app[m
[32m+[m
[32m+[m[32m# Tracks metadata for the flutter migrate command[m
[32m+[m[32mmigration:[m
[32m+[m[32m  platforms:[m
[32m+[m[32m    - platform: root[m
[32m+[m[32m      create_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m      base_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m    - platform: android[m
[32m+[m[32m      create_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m      base_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m    - platform: ios[m
[32m+[m[32m      create_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m      base_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m    - platform: linux[m
[32m+[m[32m      create_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m      base_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m    - platform: macos[m
[32m+[m[32m      create_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m      base_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m    - platform: web[m
[32m+[m[32m      create_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m      base_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m    - platform: windows[m
[32m+[m[32m      create_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m[32m      base_revision: 9f455d2486bcb28cad87b062475f42edc959f636[m
[32m+[m
[32m+[m[32m  # User provided section[m
[32m+[m
[32m+[m[32m  # List of Local paths (relative to this file) that should be[m
[32m+[m[32m  # ignored by the migrate tool.[m
[32m+[m[32m  #[m
[32m+[m[32m  # Files that are not part of the templates will be ignored by default.[m
[32m+[m[32m  unmanaged_files:[m
[32m+[m[32m    - 'lib/main.dart'[m
[32m+[m[32m    - 'ios/Runner.xcodeproj/project.pbxproj'[m
[1mdiff --git a/.vscode/settings.json b/.vscode/settings.json[m
[1mnew file mode 100644[m
[1mindex 0000000..adfd157[m
[1m--- /dev/null[m
[1m+++ b/.vscode/settings.json[m
[36m@@ -0,0 +1,3 @@[m
[32m+[m[32m{[m
[32m+[m[32m    "cmake.sourceDirectory": "C:/flutter/duckyapp/linux"[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/README.md b/README.md[m
[1mnew file mode 100644[m
[1mindex 0000000..938f627[m
[1m--- /dev/null[m
[1m+++ b/README.md[m
[36m@@ -0,0 +1,16 @@[m
[32m+[m[32m# duckyapp[m
[32m+[m
[32m+[m[32mA new Flutter project.[m
[32m+[m
[32m+[m[32m## Getting Started[m
[32m+[m
[32m+[m[32mThis project is a starting point for a Flutter application.[m
[32m+[m
[32m+[m[32mA few resources to get you started if this is your first Flutter project:[m
[32m+[m
[32m+[m[32m- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)[m
[32m+[m[32m- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)[m
[32m+[m
[32m+[m[32mFor help getting started with Flutter development, view the[m
[32m+[m[32m[online documentation](https://docs.flutter.dev/), which offers tutorials,[m
[32m+[m[32msamples, guidance on mobile development, and a full API reference.[m
[1mdiff --git a/analysis_options.yaml b/analysis_options.yaml[m
[1mnew file mode 100644[m
[1mindex 0000000..0d29021[m
[1m--- /dev/null[m
[1m+++ b/analysis_options.yaml[m
[36m@@ -0,0 +1,28 @@[m
[32m+[m[32m# This file configures the analyzer, which statically analyzes Dart code to[m
[32m+[m[32m# check for errors, warnings, and lints.[m
[32m+[m[32m#[m
[32m+[m[32m# The issues identified by the analyzer are surfaced in the UI of Dart-enabled[m
[32m+[m[32m# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be[m
[32m+[m[32m# invoked from the command line by running `flutter analyze`.[m
[32m+[m
[32m+[m[32m# The following line activates a set of recommended lints for Flutter apps,[m
[32m+[m[32m# packages, and plugins designed to encourage good coding practices.[m
[32m+[m[32minclude: package:flutter_lints/flutter.yaml[m
[32m+[m
[32m+[m[32mlinter:[m
[32m+[m[32m  # The lint rules applied to this project can be customized in the[m
[32m+[m[32m  # section below to disable rules from the `package:flutter_lints/flutter.yaml`[m
[32m+[m[32m  # included above or to enable additional rules. A list of all available lints[m
[32m+[m[32m  # and their documentation is published at https://dart.dev/lints.[m
[32m+[m[32m  #[m
[32m+[m[32m  # Instead of disabling a lint rule for the entire project in the[m
[32m+[m[32m  # section below, it can also be suppressed for a single line of code[m
[32m+[m[32m  # or a specific dart file by using the `// ignore: name_of_lint` and[m
[32m+[m[32m  # `// ignore_for_file: name_of_lint` syntax on the line or in the file[m
[32m+[m[32m  # producing the lint.[m
[32m+[m[32m  rules:[m
[32m+[m[32m    # avoid_print: false  # Uncomment to disable the `avoid_print` rule[m
[32m+[m[32m    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule[m
[32m+[m
[32m+[m[32m# Additional information about this file can be found at[m
[32m+[m[32m# https://dart.dev/guides/language/analysis-options[m
[1mdiff --git a/android/.gitignore b/android/.gitignore[m
[1mnew file mode 100644[m
[1mindex 0000000..be3943c[m
[1m--- /dev/null[m
[1m+++ b/android/.gitignore[m
[36m@@ -0,0 +1,14 @@[m
[32m+[m[32mgradle-wrapper.jar[m
[32m+[m[32m/.gradle[m
[32m+[m[32m/captures/[m
[32m+[m[32m/gradlew[m
[32m+[m[32m/gradlew.bat[m
[32m+[m[32m/local.properties[m
[32m+[m[32mGeneratedPluginRegistrant.java[m
[32m+[m[32m.cxx/[m
[32m+[m
[32m+[m[32m# Remember to never publicly share your keystore.[m
[32m+[m[32m# See https://flutter.dev/to/reference-keystore[m
[32m+[m[32mkey.properties[m
[32m+[m[32m**/*.keystore[m
[32m+[m[32m**/*.jks[m
[1mdiff --git a/android/app/build.gradle.kts b/android/app/build.gradle.kts[m
[1mnew file mode 100644[m
[1mindex 0000000..3ee99c4[m
[1m--- /dev/null[m
[1m+++ b/android/app/build.gradle.kts[m
[36m@@ -0,0 +1,47 @@[m
[32m+[m[32mplugins {[m
[32m+[m[32m    id("com.android.application")[m
[32m+[m[32m    // START: FlutterFire Configuration[m
[32m+[m[32m    id("com.google.gms.google-services")[m
[32m+[m[32m    // END: FlutterFire Configuration[m
[32m+[m[32m    id("kotlin-android")[m
[32m+[m[32m    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.[m
[32m+[m[32m    id("dev.flutter.flutter-gradle-plugin")[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mandroid {[m
[32m+[m[32m    namespace = "com.ducky.duckyapp"[m
[32m+[m[32m    compileSdk = flutter.compileSdkVersion[m
[32m+[m[32m    ndkVersion = flutter.ndkVersion[m
[32m+[m
[32m+[m[32m    compileOptions {[m
[32m+[m[32m        sourceCompatibility = JavaVersion.VERSION_11[m
[32m+[m[32m        targetCompatibility = JavaVersion.VERSION_11[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    kotlinOptions {[m
[32m+[m[32m        jvmTarget = JavaVersion.VERSION_11.toString()[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    defaultConfig {[m
[32m+[m[32m        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).[m
[32m+[m[32m        applicationId = "com.ducky.duckyapp"[m
[32m+[m[32m        // You can update the following values to match your application needs.[m
[32m+[m[32m        // For more information, see: https://flutter.dev/to/review-gradle-config.[m
[32m+[m[32m        minSdk = flutter.minSdkVersion[m
[32m+[m[32m        targetSdk = flutter.targetSdkVersion[m
[32m+[m[32m        versionCode = flutter.versionCode[m
[32m+[m[32m        versionName = flutter.versionName[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    buildTypes {[m
[32m+[m[32m        release {[m
[32m+[m[32m            // TODO: Add your own signing config for the release build.[m
[32m+[m[32m            // Signing with the debug keys for now, so `flutter run --release` works.[m
[32m+[m[32m            signingConfig = signingConfigs.getByName("debug")[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mflutter {[m
[32m+[m[32m    source = "../.."[m
[32m+[m[32m}[m
[1mdiff --git a/android/app/google-services.json b/android/app/google-services.json[m
[1mnew file mode 100644[m
[1mindex 0000000..f0f908e[m
[1m--- /dev/null[m
[1m+++ b/android/app/google-services.json[m
[36m@@ -0,0 +1,29 @@[m
[32m+[m[32m{[m
[32m+[m[32m  "project_info": {[m
[32m+[m[32m    "project_number": "1066173331667",[m
[32m+[m[32m    "project_id": "ducpeppa",[m
[32m+[m[32m    "storage_bucket": "ducpeppa.firebasestorage.app"[m
[32m+[m[32m  },[m
[32m+[m[32m  "client": [[m
[32m+[m[32m    {[m
[32m+[m[32m      "client_info": {[m
[32m+[m[32m        "mobilesdk_app_id": "1:1066173331667:android:679c026cbe9f57321e3c26",[m
[32m+[m[32m        "android_client_info": {[m
[32m+[m[32m          "package_name": "com.ducky.duckyapp"[m
[32m+[m[32m        }[m
[32m+[m[32m      },[m
[32m+[m[32m      "oauth_client": [],[m
[32m+[m[32m      "api_key": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "current_key": "AIzaSyDUWJRdmmbBKGERlY0WskWNoMxlLPpyLCc"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "services": {[m
[32m+[m[32m        "appinvite_service": {[m
[32m+[m[32m          "other_platform_oauth_client": [][m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m[32m  ],[m
[32m+[m[32m  "configuration_version": "1"[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/android/app/src/debug/AndroidManifest.xml b/android/app/src/debug/AndroidManifest.xml[m
[1mnew file mode 100644[m
[1mindex 0000000..399f698[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/debug/AndroidManifest.xml[m
[36m@@ -0,0 +1,7 @@[m
[32m+[m[32m<manifest xmlns:android="http://schemas.android.com/apk/res/android">[m
[32m+[m[32m    <!-- The INTERNET permission is required for development. Specifically,[m
[32m+[m[32m         the Flutter tool needs it to communicate with the running application[m
[32m+[m[32m         to allow setting breakpoints, to provide hot reload, etc.[m
[32m+[m[32m    -->[m
[32m+[m[32m    <uses-permission android:name="android.permission.INTERNET"/>[m
[32m+[m[32m</manifest>[m
[1mdiff --git a/android/app/src/main/AndroidManifest.xml b/android/app/src/main/AndroidManifest.xml[m
[1mnew file mode 100644[m
[1mindex 0000000..4a113bb[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/main/AndroidManifest.xml[m
[36m@@ -0,0 +1,45 @@[m
[32m+[m[32m<manifest xmlns:android="http://schemas.android.com/apk/res/android">[m
[32m+[m[32m    <application[m
[32m+[m[32m        android:label="duckyapp"[m
[32m+[m[32m        android:name="${applicationName}"[m
[32m+[m[32m        android:icon="@mipmap/ic_launcher">[m
[32m+[m[32m        <activity[m
[32m+[m[32m            android:name=".MainActivity"[m
[32m+[m[32m            android:exported="true"[m
[32m+[m[32m            android:launchMode="singleTop"[m
[32m+[m[32m            android:taskAffinity=""[m
[32m+[m[32m            android:theme="@style/LaunchTheme"[m
[32m+[m[32m            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"[m
[32m+[m[32m            android:hardwareAccelerated="true"[m
[32m+[m[32m            android:windowSoftInputMode="adjustResize">[m
[32m+[m[32m            <!-- Specifies an Android theme to apply to this Activity as soon as[m
[32m+[m[32m                 the Android process has started. This theme is visible to the user[m
[32m+[m[32m                 while the Flutter UI initializes. After that, this theme continues[m
[32m+[m[32m                 to determine the Window background behind the Flutter UI. -->[m
[32m+[m[32m            <meta-data[m
[32m+[m[32m              android:name="io.flutter.embedding.android.NormalTheme"[m
[32m+[m[32m              android:resource="@style/NormalTheme"[m
[32m+[m[32m              />[m
[32m+[m[32m            <intent-filter>[m
[32m+[m[32m                <action android:name="android.intent.action.MAIN"/>[m
[32m+[m[32m                <category android:name="android.intent.category.LAUNCHER"/>[m
[32m+[m[32m            </intent-filter>[m
[32m+[m[32m        </activity>[m
[32m+[m[32m        <!-- Don't delete the meta-data below.[m
[32m+[m[32m             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->[m
[32m+[m[32m        <meta-data[m
[32m+[m[32m            android:name="flutterEmbedding"[m
[32m+[m[32m            android:value="2" />[m
[32m+[m[32m    </application>[m
[32m+[m[32m    <!-- Required to query activities that can process text, see:[m
[32m+[m[32m         https://developer.android.com/training/package-visibility and[m
[32m+[m[32m         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.[m
[32m+[m
[32m+[m[32m         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->[m
[32m+[m[32m    <queries>[m
[32m+[m[32m        <intent>[m
[32m+[m[32m            <action android:name="android.intent.action.PROCESS_TEXT"/>[m
[32m+[m[32m            <data android:mimeType="text/plain"/>[m
[32m+[m[32m        </intent>[m
[32m+[m[32m    </queries>[m
[32m+[m[32m</manifest>[m
[1mdiff --git a/android/app/src/main/kotlin/com/ducky/duckyapp/MainActivity.kt b/android/app/src/main/kotlin/com/ducky/duckyapp/MainActivity.kt[m
[1mnew file mode 100644[m
[1mindex 0000000..31bf42a[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/main/kotlin/com/ducky/duckyapp/MainActivity.kt[m
[36m@@ -0,0 +1,5 @@[m
[32m+[m[32mpackage com.ducky.duckyapp[m
[32m+[m
[32m+[m[32mimport io.flutter.embedding.android.FlutterActivity[m
[32m+[m
[32m+[m[32mclass MainActivity : FlutterActivity()[m
[1mdiff --git a/android/app/src/main/res/drawable-v21/launch_background.xml b/android/app/src/main/res/drawable-v21/launch_background.xml[m
[1mnew file mode 100644[m
[1mindex 0000000..f74085f[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/main/res/drawable-v21/launch_background.xml[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?xml version="1.0" encoding="utf-8"?>[m
[32m+[m[32m<!-- Modify this file to customize your launch splash screen -->[m
[32m+[m[32m<layer-list xmlns:android="http://schemas.android.com/apk/res/android">[m
[32m+[m[32m    <item android:drawable="?android:colorBackground" />[m
[32m+[m
[32m+[m[32m    <!-- You can insert your own image assets here -->[m
[32m+[m[32m    <!-- <item>[m
[32m+[m[32m        <bitmap[m
[32m+[m[32m            android:gravity="center"[m
[32m+[m[32m            android:src="@mipmap/launch_image" />[m
[32m+[m[32m    </item> -->[m
[32m+[m[32m</layer-list>[m
[1mdiff --git a/android/app/src/main/res/drawable/launch_background.xml b/android/app/src/main/res/drawable/launch_background.xml[m
[1mnew file mode 100644[m
[1mindex 0000000..304732f[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/main/res/drawable/launch_background.xml[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?xml version="1.0" encoding="utf-8"?>[m
[32m+[m[32m<!-- Modify this file to customize your launch splash screen -->[m
[32m+[m[32m<layer-list xmlns:android="http://schemas.android.com/apk/res/android">[m
[32m+[m[32m    <item android:drawable="@android:color/white" />[m
[32m+[m
[32m+[m[32m    <!-- You can insert your own image assets here -->[m
[32m+[m[32m    <!-- <item>[m
[32m+[m[32m        <bitmap[m
[32m+[m[32m            android:gravity="center"[m
[32m+[m[32m            android:src="@mipmap/launch_image" />[m
[32m+[m[32m    </item> -->[m
[32m+[m[32m</layer-list>[m
[1mdiff --git a/android/app/src/main/res/mipmap-hdpi/ic_launcher.png b/android/app/src/main/res/mipmap-hdpi/ic_launcher.png[m
[1mnew file mode 100644[m
[1mindex 0000000..db77bb4[m
Binary files /dev/null and b/android/app/src/main/res/mipmap-hdpi/ic_launcher.png differ
[1mdiff --git a/android/app/src/main/res/mipmap-mdpi/ic_launcher.png b/android/app/src/main/res/mipmap-mdpi/ic_launcher.png[m
[1mnew file mode 100644[m
[1mindex 0000000..17987b7[m
Binary files /dev/null and b/android/app/src/main/res/mipmap-mdpi/ic_launcher.png differ
[1mdiff --git a/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png b/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png[m
[1mnew file mode 100644[m
[1mindex 0000000..09d4391[m
Binary files /dev/null and b/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png differ
[1mdiff --git a/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png b/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png[m
[1mnew file mode 100644[m
[1mindex 0000000..d5f1c8d[m
Binary files /dev/null and b/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png differ
[1mdiff --git a/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png b/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png[m
[1mnew file mode 100644[m
[1mindex 0000000..4d6372e[m
Binary files /dev/null and b/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png differ
[1mdiff --git a/android/app/src/main/res/values-night/styles.xml b/android/app/src/main/res/values-night/styles.xml[m
[1mnew file mode 100644[m
[1mindex 0000000..06952be[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/main/res/values-night/styles.xml[m
[36m@@ -0,0 +1,18 @@[m
[32m+[m[32m<?xml version="1.0" encoding="utf-8"?>[m
[32m+[m[32m<resources>[m
[32m+[m[32m    <!-- Theme applied to the Android Window while the process is starting when the OS's Dark Mode setting is on -->[m
[32m+[m[32m    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">[m
[32m+[m[32m        <!-- Show a splash screen on the activity. Automatically removed when[m
[32m+[m[32m             the Flutter engine draws its first frame -->[m
[32m+[m[32m        <item name="android:windowBackground">@drawable/launch_background</item>[m
[32m+[m[32m    </style>[m
[32m+[m[32m    <!-- Theme applied to the Android Window as soon as the process has started.[m
[32m+[m[32m         This theme determines the color of the Android Window while your[m
[32m+[m[32m         Flutter UI initializes, as well as behind your Flutter UI while its[m
[32m+[m[32m         running.[m
[32m+[m
[32m+[m[32m         This Theme is only used starting with V2 of Flutter's Android embedding. -->[m
[32m+[m[32m    <style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">[m
[32m+[m[32m        <item name="android:windowBackground">?android:colorBackground</item>[m
[32m+[m[32m    </style>[m
[32m+[m[32m</resources>[m
[1mdiff --git a/android/app/src/main/res/values/styles.xml b/android/app/src/main/res/values/styles.xml[m
[1mnew file mode 100644[m
[1mindex 0000000..cb1ef88[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/main/res/values/styles.xml[m
[36m@@ -0,0 +1,18 @@[m
[32m+[m[32m<?xml version="1.0" encoding="utf-8"?>[m
[32m+[m[32m<resources>[m
[32m+[m[32m    <!-- Theme applied to the Android Window while the process is starting when the OS's Dark Mode setting is off -->[m
[32m+[m[32m    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">[m
[32m+[m[32m        <!-- Show a splash screen on the activity. Automatically removed when[m
[32m+[m[32m             the Flutter engine draws its first frame -->[m
[32m+[m[32m        <item name="android:windowBackground">@drawable/launch_background</item>[m
[32m+[m[32m    </style>[m
[32m+[m[32m    <!-- Theme applied to the Android Window as soon as the process has started.[m
[32m+[m[32m         This theme determines the color of the Android Window while your[m
[32m+[m[32m         Flutter UI initializes, as well as behind your Flutter UI while its[m
[32m+[m[32m         running.[m
[32m+[m
[32m+[m[32m         This Theme is only used starting with V2 of Flutter's Android embedding. -->[m
[32m+[m[32m    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">[m
[32m+[m[32m        <item name="android:windowBackground">?android:colorBackground</item>[m
[32m+[m[32m    </style>[m
[32m+[m[32m</resources>[m
[1mdiff --git a/android/app/src/profile/AndroidManifest.xml b/android/app/src/profile/AndroidManifest.xml[m
[1mnew file mode 100644[m
[1mindex 0000000..399f698[m
[1m--- /dev/null[m
[1m+++ b/android/app/src/profile/AndroidManifest.xml[m
[36m@@ -0,0 +1,7 @@[m
[32m+[m[32m<manifest xmlns:android="http://schemas.android.com/apk/res/android">[m
[32m+[m[32m    <!-- The INTERNET permission is required for development. Specifically,[m
[32m+[m[32m         the Flutter tool needs it to communicate with the running application[m
[32m+[m[32m         to allow setting breakpoints, to provide hot reload, etc.[m
[32m+[m[32m    -->[m
[32m+[m[32m    <uses-permission android:name="android.permission.INTERNET"/>[m
[32m+[m[32m</manifest>[m
[1mdiff --git a/android/build.gradle.kts b/android/build.gradle.kts[m
[1mnew file mode 100644[m
[1mindex 0000000..dbee657[m
[1m--- /dev/null[m
[1m+++ b/android/build.gradle.kts[m
[36m@@ -0,0 +1,24 @@[m
[32m+[m[32mallprojects {[m
[32m+[m[32m    repositories {[m
[32m+[m[32m        google()[m
[32m+[m[32m        mavenCentral()[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mval newBuildDir: Directory =[m
[32m+[m[32m    root