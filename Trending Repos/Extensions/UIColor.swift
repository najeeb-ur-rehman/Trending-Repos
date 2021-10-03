//
//  UIColor.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 04/10/2021.
//

import UIKit

extension UIColor {
	
	public convenience init(_ value: Int) {
		let r = CGFloat(value >> 16 & 0xFF) / 255.0
		let g = CGFloat(value >> 8 & 0xFF) / 255.0
		let b = CGFloat(value & 0xFF) / 255.0
		self.init(red: r, green: g, blue: b, alpha: 1.0)
	}
	
	static func colorFromString(_ str: String) -> UIColor {
		let hash = abs(str.hashValue)
		let colorNum = hash % (256*256*256)
		let color = UIColor(colorNum)
		return color
	}
}
