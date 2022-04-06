import Foundation
import Capacitor
import AntourageViewer

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(AntourageCapacitor)
public class AntourageCapacitor: CAPPlugin {
    private var widget: Widget!
    private var bottomConstraint: NSLayoutConstraint?
    private var bottomMargin: CGFloat = 0 {
        didSet {
            DispatchQueue.main.async {
                self.bottomConstraint?.constant = self.bottomMargin
            }
        }
    }

    @objc
    func configure(_ call: CAPPluginCall) {
        guard let teamID = call.getInt("teamId") else {
            return call.reject("Must provide a teamId")
        }

        Antourage.shared.teamID = teamID

        DispatchQueue.main.async {
            let widget = Widget()
            widget.translatesAutoresizingMaskIntoConstraints = false
            self.widget = widget
        }
    }

    @objc
    func registerNotifications(_ call: CAPPluginCall) {
        guard let fcmToken = call.getString("fcmToken") else {
            return call.reject("Must provide an fcmToken")
        }

        Antourage.shared.registerForRemoteNotifications(fcmToken: fcmToken) { topic in
            if let topic = topic {
                call.resolve(["topic": topic])
            } else {
                call.reject("Failed to register notifications")
            }
        }
    }

    @objc
    func unregisterNotifications(_ call: CAPPluginCall) {
        Antourage.shared.unregisterForRemoteNotifications { success in
            if success {
                call.resolve()
            } else {
                call.reject("Failed to unregister notifications")
            }
        }
    }

    @objc
    func showWidget(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [self] in
            guard widget.superview == nil, let superview = bridge.viewController.view else { return }
            superview.addSubview(widget)

            widget.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            bottomConstraint = superview.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: widget.bottomAnchor, constant: bottomMargin)
            bottomConstraint?.isActive = true
        }
    }

    @objc
    func hideWidget(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            self.widget.removeFromSuperview()
        }
    }

    @objc
    func setBottomMargin(_ call: CAPPluginCall) {
        guard call.getString("platform") != "android", let margin = call.getFloat("margin") else {
            return
        }

        bottomMargin = CGFloat(margin)
    }

    @objc
    func setPortalColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.portalColor = color
        }
    }

    @objc
    func setNameTextColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.nameTextColor = color
        }
    }

    @objc
    func setNameBackgroundColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.nameBackgroundColor = color
        }
    }

    @objc
    func setTitleTextColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.titleTextColor = color
        }
    }

    @objc
    func setTitleBackgroundColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.titleBackgroundColor = color
        }
    }

    @objc
    func setCtaTextColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.ctaTextColor = color
        }
    }

    @objc
    func setCtaBackgroundColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.ctaBackgroundColor = color
        }
    }

    @objc
    func setLiveDotColor(_ call: CAPPluginCall) {
        guard let colorString = call.getString("color"), let color = UIColor(hex: colorString) else {
            call.reject("Must provide a valid color")
            return
        }

        DispatchQueue.main.async {
            self.widget.liveDotColor = color
        }
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
