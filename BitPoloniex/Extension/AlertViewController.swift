//
//  AlertViewController.swift
//  BitPoloniex
//
//  Created by Burhanuddin Sunelwala on 2/4/19.
//  Copyright © 2019 burhanuddin353. All rights reserved.
//

import UIKit

extension UIAlertController {

    //MARK: "OK" alerts
    static func okAlert(withTitle title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))

        return alertController
    }
}
