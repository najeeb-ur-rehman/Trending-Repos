//
//  Bindable.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import Foundation

class Bindable<T> {
	
	var value: T {
		didSet {
			updateHandler?(value)
		}
	}
	var updateHandler: ((T) -> Void)?
	
	init(_ value: T) {
		self.value = value
	}
}
