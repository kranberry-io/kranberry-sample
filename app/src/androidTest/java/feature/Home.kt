package feature

import androidx.test.uiautomator.UiDevice
import io.kranberry.outputs.ScreenshotHandler.takeScreenshot
import io.kranberry.ui.BaseUi
import io.kranberry.ui.elementIsPresentByTextContains

class Home(device: UiDevice) : BaseUi(device) {

    fun shouldSeeFlowerList(): Home {
        assert(elementIsPresentByTextContains("Flowers"))
        takeScreenshot()
        return this
    }
}