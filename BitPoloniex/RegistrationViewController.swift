//
//  RegistrationViewController.swift
//  BitPoloniex
//
//  Created by Burhanuddin Sunelwala on 2/3/19.
//  Copyright © 2019 burhanuddin353. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK:- IBActions
extension RegistrationViewController {

    @IBAction private func registerClicked(_ button: UIButton) {

        dismiss(animated: true)
    }
}
