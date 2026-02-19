import UIKit

final class AlertPresenter {
    func show(in vc: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )

        let action = UIAlertAction(
            title: model.buttonText,
            style: .default
        ) { _ in
            model.completion()
        }

        alert.addAction(action)

        vc.present(alert, animated: true) {
            alert.view.tintColor = .systemBlue
            
            Self.applyTint(to: alert.view, color: .systemBlue)
            
            if let titleLabel = alert.view.value(forKeyPath: "_titleLabel") as? UILabel {
                titleLabel.textAlignment = .center
            }
            
            if let messageLabel = alert.view.value(forKeyPath: "_messageLabel") as? UILabel {
                messageLabel.textAlignment = .center
            }
        }
    }
    
    private static func applyTint(to view: UIView, color: UIColor) {
        view.tintColor = color
        for subview in view.subviews {
            applyTint(to: subview, color: color)
        }
    }
}
