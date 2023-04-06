import UIKit
import SwiftUI

extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {

        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    var preview: some View {
        return Preview(viewController: self)
    }
}

extension UIView {

    private struct Preview: UIViewRepresentable {

        let uiView: UIView
        typealias UIViewType = UIView

        func makeUIView(context: Context) -> UIView {
            uiView
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            return
        }
    }

    var preview: some View {
        return Preview(uiView: self)
    }
}
