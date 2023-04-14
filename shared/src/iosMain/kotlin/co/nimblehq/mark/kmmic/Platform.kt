@file:Suppress("MatchingDeclarationName")
package co.nimblehq.mark.kmmic

import platform.UIKit.UIDevice

@Suppress("MatchingDeclarationName")
class IOSPlatform: Platform {
    override val name: String = UIDevice.currentDevice.systemName() + " " + UIDevice.currentDevice.systemVersion
}

actual fun getPlatform(): Platform = IOSPlatform()
