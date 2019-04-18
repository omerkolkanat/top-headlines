//
//  AlertHelper.swift
//  TopHeadlines
//
//  Created by Omer Kolkanat on 18.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper: NSObject {
    
    enum AlertMessage: String {
        case OfflineUsageErrorMessage = "For offline usage, you should connect to internet at the first open"
    }
    
    enum AlertTitle: String {
        case Warning = "Warning"
        case Error = "Error"
    }
    
    static func showAlert(title: String, message: String, fromController: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: UIAlertAction.Style.default,
                                                handler: nil))
        fromController.present(alertController, animated: true, completion: nil)
    }
    
    static func showOfflineUsageErrorAlert(fromController: UIViewController){
        showAlert(title: AlertTitle.Warning.rawValue,
                  message: AlertMessage.OfflineUsageErrorMessage.rawValue,
                  fromController: fromController)
    }
}
