//
//  TrendingRepoTableViewCell.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 30/09/2021.
//

import UIKit

class TrendingRepoTableViewCell: UITableViewCell {
	
	var isExpanded: Bool {
		!languageAndStarsView.isHidden && !descriptionLabel.isHidden
	}

	// MARK: Outlets
	
	@IBOutlet weak var outerView: UIView!
	@IBOutlet weak var userPhotoImageView: UIImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var repoNameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var languageAndStarsView: UIView!
	@IBOutlet weak var languageColorView: UIView!
	@IBOutlet weak var languageNameLabel: UILabel!
	@IBOutlet weak var starIconImageView: UIImageView!
	@IBOutlet weak var starCountLabel: UILabel!
	
	// MARK: View Lifecycle Methods
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		setupUI()
		showEpandedView(false)
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		let shouldExpand = selected && !isExpanded
		showEpandedView(shouldExpand)
	}
	
	// MARK: Helper Methods
	
	func showEpandedView(_ expand: Bool) {
		languageAndStarsView.isHidden = !expand
		descriptionLabel.isHidden = !expand
	}
	
}

// MARK: - Private Methods

private extension TrendingRepoTableViewCell {
	
	func setupUI() {
		userNameLabel.font = Font.medium(13)
		userNameLabel.textColor = Color.secondaryTextColor
		
		repoNameLabel.font = Font.bold(15)
		repoNameLabel.textColor = Color.primaryTextColor
		
		descriptionLabel.font = Font.regular(13)
		descriptionLabel.textColor = Color.secondaryTextColor
		
		userPhotoImageView.setCornerRadius(20)
		
		languageColorView.setCornerRadius(6)
		
		languageNameLabel.font = Font.medium(12)
		languageNameLabel.textColor = Color.secondaryTextColor
		
		starCountLabel.font = Font.medium(12)
		starCountLabel.textColor = Color.secondaryTextColor
	}
	
}
