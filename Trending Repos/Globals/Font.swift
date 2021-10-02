//
//  Font.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import UIKit

enum Font {
	
	static func regular(_ size: CGFloat) -> UIFont {
		return UIFont(name: "HelveticaNeue", size: size)!
	}
	
	static func medium(_ size: CGFloat) -> UIFont {
		return UIFont(name: "HelveticaNeue-Medium", size: size)!
	}
	
	static func bold(_ size: CGFloat) -> UIFont {
		return UIFont(name: "HelveticaNeue-Bold", size: size)!
	}
	
}
