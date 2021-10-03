//
//  UITableView.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 03/10/2021.
//

import UIKit

extension UITableView {
	
	func configureRefreshControlWithTarget(_ target: Any, andSelector selector: Selector) {
		let refreshControl = UIRefreshControl()
		refreshControl.tintColor = Color.primaryColor
		self.refreshControl = refreshControl
		refreshControl.addTarget(target, action: selector, for: .valueChanged)
	}
	
	func endRefreshing() {
		self.refreshControl?.endRefreshing()
	}
	
}
