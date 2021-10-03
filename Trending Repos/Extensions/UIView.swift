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
	
	func setBorderColor(_ color: UIColor?, andWidth width: CGFloat = 1.0){
		layer.borderColor = color?.cgColor
		layer.borderWidth = width
	}
	
	@discardableResult
	func loadFromNib<T : UIView>() -> T? {
		let bundle = Bundle(for: type(of: self))
		let loadedView = bundle.loadNibNamed(String(describing: type(of: self)),
											 owner: self,
											 options: nil)?.first
		guard let contentView = loadedView as? T else {
			return nil
		}
		return contentView
	}
	
	func fixInView(_ container: UIView) {
		frame = container.bounds
		container.addSubview(self)
		addEqualConstraintsWith(container)
	}
	
	func addEqualConstraintsWith(_ view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		[NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
		NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
		NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
		NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)].forEach { $0.isActive = true }
	}
}

