@file:Suppress("MatchingDeclarationName")
package co.nimblehq.mark.kmmic

import kotlin.test.Test
import kotlin.test.assertTrue

@Suppress("naming.MatchingDeclarationName")
class IosGreetingTest {

    @Test
    fun testExample() {
        assertTrue(Greeting().greet().contains("iOS"), "Check iOS is mentioned")
    }
}
