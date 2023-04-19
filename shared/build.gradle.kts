import com.codingfeline.buildkonfig.compiler.FieldSpec.Type.STRING
import org.jetbrains.kotlin.gradle.plugin.mpp.NativeBuildType

plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    kotlin("plugin.serialization")
    id("kotlinx-serialization")
    id("com.android.library")
    id("com.codingfeline.buildkonfig")
    id("com.google.devtools.ksp").version("1.7.10-1.0.6")
    id("com.rickclephas.kmp.nativecoroutines").version("0.12.6-new-mm")
}

kotlin {
    android()
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    cocoapods {
        summary = "Some description for the Shared Module"
        homepage = "Link to the Shared Module homepage"
        version = "1.0"
        ios.deploymentTarget = "14.1"
        framework {
            baseName = "Shared"
        }


        xcodeConfigurationToNativeBuildType["Debug Production"] = NativeBuildType.DEBUG
        xcodeConfigurationToNativeBuildType["Debug Staging"] = NativeBuildType.DEBUG
        xcodeConfigurationToNativeBuildType["Release Production"] = NativeBuildType.RELEASE
        xcodeConfigurationToNativeBuildType["Release Staging"] = NativeBuildType.RELEASE
    }

    sourceSets {
        all {
            languageSettings.optIn("kotlin.experimental.ExperimentalObjCName")
        }
        val commonMain by getting {
            dependencies {
                // Coroutines
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.4")

                // Koin
                implementation("io.insert-koin:koin-core:3.2.0")
                implementation("io.insert-koin:koin-test:3.2.0")

                // Ktor
                implementation("io.ktor:ktor-client-core:2.1.1")
                implementation("io.ktor:ktor-client-content-negotiation:2.1.1")
                implementation("io.ktor:ktor-serialization-kotlinx-json:2.1.1")
                implementation("io.ktor:ktor-client-logging:2.1.1")

                // JsonApi
                implementation(project(":jsonapi-kotlin:core"))

                // Kotlinx Serialization
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.5.0")

                // Napier
                implementation("io.github.aakira:napier:2.4.0")

                // Setting
                implementation("com.russhwolf:multiplatform-settings-no-arg:1.0.0-RC")
                implementation("com.russhwolf:multiplatform-settings-serialization:1.0.0-RC")
            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.6.4")
            }
        }
        val androidMain by getting
        val androidTest by getting
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)

            dependencies {
                implementation("io.ktor:ktor-client-darwin:2.1.1")
            }
        }
        val iosX64Test by getting
        val iosArm64Test by getting
        val iosSimulatorArm64Test by getting
        val iosTest by creating {
            dependsOn(commonTest)
            iosX64Test.dependsOn(this)
            iosArm64Test.dependsOn(this)
            iosSimulatorArm64Test.dependsOn(this)
        }
    }
}

android {
    namespace = "co.nimblehq.mark.kmmic"
    compileSdk = 32
    defaultConfig {
        minSdk = 21
        targetSdk = 32
    }
}

val detekt by configurations.creating

val detektTask = tasks.register<JavaExec>("detekt") {
    main = "io.gitlab.arturbosch.detekt.cli.Main"
    classpath = detekt

    val input = "$projectDir"
    val config = "$projectDir/detekt.yml"
    val exclude = ".*/build/.*,.*/resources/.*,**/*.kts"
    val report = "sarif:$buildDir/reports/detekt/report.sarif"
    val params = listOf("-i", input, "-c", config, "-ex", exclude, "-r", report)

    args(params)
}

dependencies {
    detekt("io.gitlab.arturbosch.detekt:detekt-cli:1.22.0")
}

val buildKonfigProperties =  rootDir.loadGradleProperties("buildKonfig.properties")

buildkonfig {
    packageName = "co.nimblehq.mark.kmmic"

    defaultConfigs {
        buildConfigField(
            STRING,
            "CLIENT_ID",
            buildKonfigProperties.getProperty("STAGING_CLIENT_ID")
        )
        buildConfigField(
            STRING,
            "CLIENT_SECRET",
            buildKonfigProperties.getProperty("STAGING_CLIENT_SECRET")
        )
        buildConfigField(
            STRING,
            "BASE_URL",
            buildKonfigProperties.getProperty("STAGING_BASE_URL")
        )
    }

    defaultConfigs("production") {
        buildConfigField(
            STRING,
            "CLIENT_ID",
            buildKonfigProperties.getProperty("PRODUCTION_CLIENT_ID")
        )
        buildConfigField(
            STRING,
            "CLIENT_SECRET",
            buildKonfigProperties.getProperty("PRODUCTION_CLIENT_SECRET")
        )
        buildConfigField(
            STRING,
            "BASE_URL",
            buildKonfigProperties.getProperty("PRODUCTION_BASE_URL")
        )
    }
}

tasks.withType<com.google.devtools.ksp.gradle.KspTask>().configureEach {
    when (this) {
        is com.google.devtools.ksp.gradle.KspTaskNative -> {
            this.compilerPluginOptions.addPluginArgument(
                tasks
                    .named<org.jetbrains.kotlin.gradle.tasks.KotlinNativeCompile>(compilation.compileKotlinTaskName)
                    .get()
                    .compilerPluginOptions
            )
        }
    }
}

nativeCoroutines {
    // The suffix used to generate the native coroutine function and property names.
    suffix = "AsNative"
}
