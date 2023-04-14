buildscript {
    dependencies {
        classpath("org.jetbrains.kotlinx:kover:0.6.1")
    }
}

plugins {
    //trick: for the same plugin versions in all sub-modules
    id("com.android.library").version("7.3.1").apply(false)
    id("org.jetbrains.kotlinx.kover") version "0.6.1"
    kotlin("multiplatform").version("1.7.10").apply(false)
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}

koverMerged {
    enable()

    filters {
        classes {
            excludes += listOf(
                "*.databinding.*",
                "*.BuildConfig"
            )
        }
    }
}

repositories {
    mavenCentral()
}

val detekt by configurations.creating

val detektTask = tasks.register<JavaExec>("detekt") {
    main = "io.gitlab.arturbosch.detekt.cli.Main"
    classpath = detekt

    val input = "$projectDir/shared"
    val config = "$projectDir/shared/detekt.yml"
    val exclude = ".*/build/.*,.*/resources/.*,**/*.kts"
    val params = listOf("-i", input, "-c", config, "-ex", exclude)

    args(params)
}

dependencies {
    detekt("io.gitlab.arturbosch.detekt:detekt-cli:1.22.0")
}
