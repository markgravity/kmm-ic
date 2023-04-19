import com.codingfeline.buildkonfig.compiler.FieldSpec.Type.STRING
import org.jetbrains.kotlin.gradle.plugin.mpp.NativeBuildType
import java.io.File
import java.util.*

plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("com.android.library")
    id("com.codingfeline.buildkonfig")
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
        val commonMain by getting
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
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

fun File.loadGradleProperties(fileName: String): Properties {
    val properties = Properties()
    val signingProperties = File(this, fileName)

    if (signingProperties.isFile) {
        properties.load(signingProperties.inputStream())
    }
    return properties
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
