//
//  Test.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 06/04/2023.
//

import SwiftUI

struct Test: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        TestViewController()
            .preview
    }
}


class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var config = UIButton.Configuration.filled()

//        config.attributedTitle = AttributedString.init(.init(string: "Annej"))
        config.image = UIImage(systemName: "arrow.right")

        config.imagePadding = 10

        let button = UIButton.init(configuration: config)

        view.addSubview(button)
        button.activateConstraintsForCenter(view: view)

        button.setAttributedTitle(.init(string: "Aaslfjalksjf"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
