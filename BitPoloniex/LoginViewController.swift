//
//  LoginViewController.swift
//  BitPoloniex
//
//  Created by Burhanuddin Sunelwala on 2/3/19.
//  Copyright © 2019 burhanuddin353. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension LoginViewController {

    @IBAction private func loginClicked(_ button: UIButton) {

        performSegue(withIdentifier: "TickerViewController", sender: nil)
    }
}
