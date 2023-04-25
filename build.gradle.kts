buildscript {
    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()
    }
    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.6.21")
        classpath("com.codingfeline.buildkonfig:buildkonfig-gradle-plugin:0.13.3")
        classpath("org.jetbrains.kotlin:kotlin-serialization:1.7.10")
    }
}

plugins {
    //trick: for the same plugin versions in all sub-modules
    id("com.android.library").version("7.2.2").apply(false)
    kotlin("multiplatform").version("1.7.10").apply(false)
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}

repositories {
    mavenCentral()
}

allprojects {
    val buildKonfigProperties =  rootDir.loadGradleProperties("buildKonfig.properties")

    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()

        maven {
            name = "Github Packages"
            url = uri("https://maven.pkg.github.com/nimblehq/jsonapi-kotlin")
            credentials {
                username = buildKonfigProperties.getProperty("GITHUB_USER")
                password = buildKonfigProperties.getProperty("GITHUB_TOKEN")
            }
        }
    }
}
