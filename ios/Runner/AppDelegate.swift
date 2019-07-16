import Firebase
import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var channelManager: RemoteConfigChannelManager!
    private var mixpanel: MixpanelChannelManager!
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        guard let rootController = window.rootViewController as? FlutterViewController else {
            fatalError("Invalid root view controller")
        }
        
        FirebaseApp.configure()
        
        let rcValues = RCValues.sharedInstance
        rcValues.fetchCloudValues()
        
        channelManager = RemoteConfigChannelManager(vc: rootController)
        channelManager.setup()
        
        mixpanel = MixpanelChannelManager(vc: rootController)
        mixpanel.setup()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
