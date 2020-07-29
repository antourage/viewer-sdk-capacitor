import Foundation
import Capacitor
import Antourage

/**
* Please read the Capacitor iOS Plugin Development Guide
* here: https://capacitor.ionicframework.com/docs/plugins/ios
*/
@objc(AntViewerPlugin)
public class AntViewerPlugin: CAPPlugin {
	
	lazy private var widget = AntWidget.shared
	
	@objc
	func showWidget(_ call: CAPPluginCall) {
		DispatchQueue.main.async { [weak self] in
			guard let mainView = self?.bridge.viewController.view else { return }
			if self?.widget.view.superview != nil { return }
			guard let widgetView = self?.widget.view else { return }
			mainView.addSubview(widgetView)
		}
	}
	
	@objc
	func hideWidget(_ call: CAPPluginCall) {
		DispatchQueue.main.async { [weak self] in
			self?.widget.view.removeFromSuperview()
		}
	}
	
	@objc
	func auth(_ call: CAPPluginCall) {
		guard let apiKey = call.getString("apiKey") else {
			return call.reject("Must provide an apiKey")
		}
		let refUserId = call.getString("refUserId")
		let nickname = call.getString("nickname")
		AntWidget.authWith(
		apiKey: apiKey,
		refUserId: refUserId,
		nickname: nickname) { result in
			switch result {
			case .success:
				call.resolve()
			case .failure(let error):
				call.reject(error.localizedDescription)
			}
			print("Auth: \(result)")
		}
	}
	
	@objc
	func registerNotifications(_ call: CAPPluginCall) {
		guard let fcmToken = call.getString("fcmToken") else {
			return call.reject("Must provide an fcmToken")
		}
		
		AntWidget.registerNotifications(FCMToken: fcmToken) { result in
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
			let feed = self.widget.getListController()
			self.bridge.viewController.present(feed, animated: true, completion: nil)
		}
	}
	
}
