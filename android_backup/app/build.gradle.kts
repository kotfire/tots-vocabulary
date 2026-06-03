plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

flutter {
    source = "../.."
}

android {
    namespace = "com.totsandtweens.vocabulary"
    compileSdk = flutter.compileSdkVersion

    defaultConfig {
        applicationId = "com.totsandtweens.vocabulary"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keystorePath = System.getenv("ANDROID_KEYSTORE_PATH")
            require(!keystorePath.isNullOrBlank()) { "ANDROID_KEYSTORE_PATH is not set" }

            val keystorePassword = System.getenv("ANDROID_KEYSTORE_PASSWORD")
            val keyAliasEnv = System.getenv("ANDROID_KEY_ALIAS")
            val keyPasswordEnv = System.getenv("ANDROID_KEY_PASSWORD")

            require(!keystorePassword.isNullOrBlank()) { "ANDROID_KEYSTORE_PASSWORD is not set" }
            require(!keyAliasEnv.isNullOrBlank()) { "ANDROID_KEY_ALIAS is not set" }
            require(!keyPasswordEnv.isNullOrBlank()) { "ANDROID_KEY_PASSWORD is not set" }

            storeFile = rootProject.file(keystorePath)
            storePassword = keystorePassword
            keyAlias = keyAliasEnv
            keyPassword = keyPasswordEnv
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}
