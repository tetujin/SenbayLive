import AVFoundation

extension DeviceUtil {
    public static func videoOrientation(by notification: Notification) -> AVCaptureVideoOrientation? {
        guard let device: UIDevice = notification.object as? UIDevice else {
            return nil
        }
        return videoOrientation(by: device.orientation)
    }

    public static func videoOrientation(by orientation: UIDeviceOrientation) -> AVCaptureVideoOrientation? {
        switch orientation {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        default:
            return nil
        }
    }
}
