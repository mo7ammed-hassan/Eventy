import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: "custom_share", binaryMessenger: controller.binaryMessenger)

            channel.setMethodCallHandler { (call, result) in
                if call.method == "share",
                   let args = call.arguments as? [String: Any],
                   let text = args["text"] as? String {
                    DispatchQueue.main.async {
                        self.shareText(text: text, controller: controller)
                    }
                    result(nil)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func shareText(text: String, controller: UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = controller.view 
        controller.present(activityViewController, animated: true, completion: nil)
    }
}
