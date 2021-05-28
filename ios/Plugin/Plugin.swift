import Foundation
import Capacitor
import Antourage
import AntourageViewer

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(AntourageCapacitor)
public class AntourageCapacitor: CAPPlugin {
  lazy private var widget = Antourage.shared
  
  public override func load() {
    super.load()
    widget.onViewerAppear = { [weak self] _ in
      self?.notifyListeners("onViewerAppear", data: [:])
    }
    widget.onViewerDisappear = { [weak self] _ in
      self?.notifyListeners("onViewerDisappear", data: [:])
    }
  }
  
  @objc
  func showWidget(_ call: CAPPluginCall) {
    DispatchQueue.main.async { [weak self] in
      guard
        self?.widget.view.superview == nil,
        let widgetView = self?.widget.view else { return }
      let mainView = self?.bridge.viewController.view
      mainView?.addSubview(widgetView)
    }
  }
  
  @objc
  func hideWidget(_ call: CAPPluginCall) {
    DispatchQueue.main.async {
      self.widget.view.removeFromSuperview()
    }
  }
  
  @objc
  func lockCapacitorControllerToPortrait(_ call: CAPPluginCall) {
    DispatchQueue.main.async {
      guard let controller = self.bridge.viewController as? CAPBridgeViewController else { return }
      controller.supportedOrientations = [UIInterfaceOrientation.portrait.rawValue]
    }
  }

  @objc
  func setPosition(_ call: CAPPluginCall) {
    guard call.getString("platform") != "android" else {
      return
    }
    guard let positionString = call.getString("position"),
      let position = WidgetPosition(rawValue: positionString) else {
      return call.reject("Must provide valid position")
    }
    DispatchQueue.main.async {
      self.widget.widgetPosition = position
    }
  }

  @objc
  func setMargins(_ call: CAPPluginCall) {
    guard call.getString("platform") != "android",
      let horizontal = call.getFloat("horizontal"),
      let vertical = call.getFloat("vertical") else {
      return 
    }
    let margins = UIOffset(horizontal: CGFloat(horizontal), vertical: CGFloat(vertical))
    DispatchQueue.main.async {
      self.widget.widgetMargins = margins
    }
  }
  
  @objc
  func configure(_ call: CAPPluginCall) {
    Antourage.configure()
  }
  
  @objc
  func registerNotifications(_ call: CAPPluginCall) {
    guard let fcmToken = call.getString("fcmToken") else {
      return call.reject("Must provide an fcmToken")
    }
    
    Antourage.registerNotifications(fcmToken: fcmToken) { result in
      switch result {
      case .success(let topic):
        call.resolve(["topic": topic])
      case .failure(let error):
        call.reject(error.localizedDescription)
      }
    }
  }
  
  @objc
  func showFeedScreen(_ call: CAPPluginCall) {
    DispatchQueue.main.async {
      self.widget.showFeed()
    }
  }
  
  @objc
  func setLocale(_ call: CAPPluginCall) {
    guard let locale = call.getString("locale") else {
      return call.reject("Must provide a locale")
    }
    DispatchQueue.main.async {
      self.widget.widgetLocale = WidgetLocale(rawValue: locale)
    }
  }
}
