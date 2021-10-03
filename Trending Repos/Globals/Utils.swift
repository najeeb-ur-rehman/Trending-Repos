//
//  Utils.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 04/10/2021.
//

import UIKit

class Utils {
	
	static func showOkAlert(title: String = "", message: String, viewController: UIViewController) {
		let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(okAction)
		viewController.present(alertController, animated: true, completion: nil)
	}

}
