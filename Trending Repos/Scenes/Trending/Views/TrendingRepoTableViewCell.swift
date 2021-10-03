//
//  TrendingRepoTableViewCell.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 30/09/2021.
//

import UIKit
import SkeletonView
import SDWebImage

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
		configureSkeletonView()
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
	
	func setRepo(_ repo: Repo) {
		userNameLabel.text = repo.user?.name
		repoNameLabel.text = repo.name
		descriptionLabel.text = repo.description
		languageNameLabel.text = repo.language
		starCountLabel.text = String(repo.stars ?? 0)
		
		let url = URL(string: repo.user?.avatarUrl ?? "")
		userPhotoImageView.sd_setImage(with: url,
									   placeholderImage: UIImage(named: "profile_placeholder"),
									   options: [], context: nil)
		
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
		
		userPhotoImageView.setCornerRadius(20, andClipContent: true)
		
		languageColorView.setCornerRadius(6)
		
		languageNameLabel.font = Font.medium(12)
		languageNameLabel.textColor = Color.secondaryTextColor
		
		starCountLabel.font = Font.medium(12)
		starCountLabel.textColor = Color.secondaryTextColor
	}
	
	func configureSkeletonView() {
		userNameLabel.lastLineFillPercent = 30
		userNameLabel.linesCornerRadius = 8
		repoNameLabel.lastLineFillPercent = 90
		repoNameLabel.linesCornerRadius = 8
	}
	
}
