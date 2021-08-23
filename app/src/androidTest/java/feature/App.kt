package feature

import androidx.test.uiautomator.UiDevice
import io.kranberry.environment.DeviceHandler.APP_PACKAGE
import io.kranberry.environment.DeviceHandler.start
import io.kranberry.outputs.ScreenshotHandler.takeScreenshot
import io.kranberry.ui.BaseUi

class App(device: UiDevice) : BaseUi(device) {

    fun open(): Home {
        start(APP_PACKAGE)
        takeScreenshot()
        return Home(device)
    }
}
