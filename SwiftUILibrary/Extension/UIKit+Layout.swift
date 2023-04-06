import UIKit

public extension UIView {

    typealias ViewAnchorConstraints = (top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?)

    @discardableResult
    func activateConstraintsForCenter(view: UIView, horizontal: Bool = true, vertical: Bool = true, offset: CGPoint = CGPoint.zero, priority: UILayoutPriority = .required) -> (centerX: NSLayoutConstraint?, centerY: NSLayoutConstraint?) {
        translatesAutoresizingMaskIntoConstraints = false
        var centerX, centerY: NSLayoutConstraint?
        if horizontal {
            centerX = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.x)
            centerX?.priority = priority
            centerX?.isActive = true
        }
        if vertical {
            centerY = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.y)
            centerY?.priority = priority
            centerY?.isActive = true
        }
        return (centerX, centerY)
    }

    @discardableResult
    func activateConstraintsForAnchors(view: UIView, top: Bool = true, leading: Bool = true, bottom: Bool = true, trailing: Bool = true, priority: UILayoutPriority = .required,
                                       insets: UIEdgeInsets = .zero) -> ViewAnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var topConstraint, leadingConstraint, bottomConstraint, trailingConstraint: NSLayoutConstraint?
        if top {
            topConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
            topConstraint?.priority = priority
            topConstraint?.isActive = true
        }
        if leading {
            leadingConstraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left)
            leadingConstraint?.priority = priority
            leadingConstraint?.isActive = true
        }
        if bottom {
            bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
            bottomConstraint?.priority = priority
            bottomConstraint?.isActive = true
        }
        if trailing {
            trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right)
            trailingConstraint?.priority = priority
            trailingConstraint?.isActive = true
        }
        return (topConstraint, leadingConstraint, bottomConstraint, trailingConstraint)
    }

    @discardableResult
    func activateConstraintsForSize(size: CGSize, priority: UILayoutPriority = .required) -> (widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = widthAnchor.constraint(equalToConstant: size.width)
        widthConstraint.priority = priority
        widthConstraint.isActive = true
        let heightConstraint = heightAnchor.constraint(equalToConstant: size.height)
        heightConstraint.priority = priority
        heightConstraint.isActive = true
        return (widthConstraint, heightConstraint)
    }
}
