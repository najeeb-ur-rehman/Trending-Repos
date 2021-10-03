//
//  EmptyDataView.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 04/10/2021.
//

import UIKit
import Lottie

class EmptyDataView: UIView {
	
	override var isHidden: Bool {
		didSet {
			if animationView == nil {
				return
			}
			if isHidden {
				animationView.stop()
			} else {
				animationView.play()
			}
		}
	}
	
	// MARK: Outlets
	
	@IBOutlet weak var animationView: AnimationView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var retryButton: UIButton!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		commonInit()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		commonInit()
	}
	
	
	// MARK: - Helper Methods
	
	private func commonInit() {
		guard let contentView = self.loadFromNib() else {
			fatalError("Failed to load nib", file: #file, line: #line)
		}
		addSubview(contentView)
		contentView.fixInView(self)
		
		setupViewAppearance()
		configureAnimationView()
	}
	
	func setupViewAppearance() {
		[titleLabel, descriptionLabel].forEach { $0.textColor = Color.primaryColor }
		titleLabel.font = Font.bold(18)
		descriptionLabel.font = Font.regular(14)
		
		retryButton.setBorderColor(Color.green)
		retryButton.setCornerRadius(5)
		retryButton.backgroundColor = Color.invertedPrimaryColor
		retryButton.titleLabel?.font = Font.bold(16)
		retryButton.setTitleColor(Color.green, for: .normal)
	}
	
	func configureAnimationView() {
		let retryAnimation = Animation.named("retry_animation")
		animationView.animation = retryAnimation
		animationView.loopMode = .loop
		animationView.backgroundBehavior = .pauseAndRestore
	}
	
}
