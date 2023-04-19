@file:Suppress("MatchingDeclarationName")
package co.nimblehq.mark.kmmic

import org.junit.Assert.assertTrue
import org.junit.Test

@Suppress("MatchingDeclarationName")
class AndroidGreetingTest {

    @Test
    fun testExample() {
        assertTrue("Check Android is mentioned", Greeting().greet().contains("Android"))
    }
}
