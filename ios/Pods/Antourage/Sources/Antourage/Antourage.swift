import UIKit
import Firebase
import AntourageViewer

@objc
public class Antourage: NSObject {
  public static var AntourageSenderId = "1090288296965"
  
  @objc
  public static let shared = Antourage()
  private override init() {
    super.init()
    firebaseAuth()
    AntWidget.shared.firebaseCreator = FireCreator()
  }
  
  public var widgetLocale: WidgetLocale? {
    get {
      AntWidget.shared.widgetLocale
    }
    set {
      AntWidget.shared.widgetLocale = newValue
    }
  }
  
  public var widgetPosition: WidgetPosition {
    get {
      AntWidget.shared.widgetPosition
    }
    set {
      AntWidget.shared.widgetPosition = newValue
    }
  }
  
  public var widgetMargins: UIOffset {
    get {
      let margins = AntWidget.shared.widgetMargins
      return UIOffset(horizontal: margins.horizontal, vertical: margins.vertical)
    }
    set {
      AntWidget.shared.widgetMargins = WidgetMargins(vertical: newValue.vertical, horizontal: newValue.horizontal)
    }
  }
  
  @objc
  public var view: UIView { AntWidget.shared.widgetView }
  @objc
  public var onViewerAppear: ((NSDictionary) -> Void)? {
    get {
      AntWidget.shared.onViewerAppear
    }
    set {
      AntWidget.shared.onViewerAppear = newValue
    }
  }
  @objc
  public var onViewerDisappear: ((NSDictionary) -> Void)? {
    get {
      AntWidget.shared.onViewerDisappear
    }
    set {
      AntWidget.shared.onViewerDisappear = newValue
    }
  }
  
  @objc
  public static func configure(path: String? = nil) {
    AntWidget.configure(path: path)
  }

  public static func registerNotifications(fcmToken: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
    AntWidget.registerNotifications(fcmToken: fcmToken, completionHandler: completionHandler)
  }

  @objc
  public static func objc_registerNotifications(FCMToken: String, completionHandler: @escaping (String?, Error?) -> Void) {
    AntWidget.objc_registerNotifications(FCMToken: FCMToken, completionHandler: completionHandler)
  }

  @objc
  public func showFeed(animated: Bool = false, backButtonHidden: Bool = false) {
    AntWidget.shared.showFeed(animated: animated, backButtonHidden: backButtonHidden)
  }
  
  private func firebaseAuth() {
    if FirebaseApp.app(name: "AntViewerFirebase") == nil {
      let filePath = Bundle(identifier: "com.antourage.viewer")!.path(forResource: "GoogleService-Info", ofType: "plist")
      guard let fileopts = FirebaseOptions(contentsOfFile: filePath!)
        else { return }
      FirebaseApp.configure(name: "AntViewerFirebase", options: fileopts)
    }

    let fbApp = FirebaseApp.app(name: "AntViewerFirebase")!
    Auth.auth(app: fbApp).signInAnonymously()
  }
}
