import UIKit

extension UILabel {
    @IBInspectable var letterSpacing: CGFloat {
        set {
            let text = self.text ?? ""
            let attributedString = NSMutableAttributedString(string: text)
            // Use NSAttributedString.Key.kern explicitly
            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: text.count))
            self.attributedText = attributedString
        }
        get {
            return (attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: nil) as? CGFloat) ?? 0
        }
    }
}
