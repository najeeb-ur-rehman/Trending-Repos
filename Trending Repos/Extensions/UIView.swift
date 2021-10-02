//
//  UIView.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import UIKit

extension UIView {
	
	func setCornerRadius(_ r : CGFloat, andClipContent clip: Bool = false) {
		layer.cornerRadius = r
		layer.masksToBounds = clip
	}
	
}

