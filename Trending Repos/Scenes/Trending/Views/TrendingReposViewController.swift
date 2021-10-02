//
//  TrendingReposViewController.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 28/09/2021.
//

import UIKit
import SkeletonView

class TrendingReposViewController: UIViewController {
	
	// MARK: Outlets
	
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: ViewController Lifecycle Methods
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Trending"
		
		tableView.showAnimatedGradientSkeleton()
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(3))
		}
	}
	
}

// MARK: -  SkeletonViewDataSource Methods

extension TrendingReposViewController: SkeletonTableViewDataSource {
	
	func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return TrendingRepoTableViewCell.reuseIdentifier
	}
	
}

// MARK: - UITableViewDataSource Methods

extension TrendingReposViewController {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 15
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TrendingRepoTableViewCell.reuseIdentifier,
												 for: indexPath) as! TrendingRepoTableViewCell
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		UIView.animate(withDuration: 0.3) {
			tableView.performBatchUpdates(nil)
		}
	}
	
}


