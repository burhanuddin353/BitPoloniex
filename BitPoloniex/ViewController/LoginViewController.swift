//
//  LoginViewController.swift
//  BitPoloniex
//
//  Created by Burhanuddin Sunelwala on 2/3/19.
//  Copyright © 2019 burhanuddin353. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
}

extension LoginViewController {

    @IBAction private func loginClicked(_ button: UIButton) {

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        MBProgressHUD.showAdded(to: view, animated: true)
        Network.shared.login(email: email, password: password) { [weak self] (result) in
            guard let strongSelf = self else { return }

            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            result.ifSuccess {

                if result.value! {
                    strongSelf.performSegue(withIdentifier: "TickerViewController", sender: nil)
                } else {
                    let alert = UIAlertController.okAlert(withTitle: "", message: "Something went wrong!\nPlease try again.")
                    strongSelf.present(alert, animated: true)
                }
            }

            result.ifFailure {

                let alert = UIAlertController.okAlert(withTitle: "Error", message: result.error!.localizedDescription)
                strongSelf.present(alert, animated: true)
            }
        }
    }

    @IBAction func unwindToLoginViewController(segue:UIStoryboardSegue) { }
}
