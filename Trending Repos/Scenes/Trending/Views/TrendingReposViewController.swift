//
//  TrendingReposViewController.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 28/09/2021.
//

import UIKit
import SkeletonView

class TrendingReposViewController: UIViewController {
	
	private let refreshControl = UIRefreshControl()
	var viewModel = TrendingRepoViewModel()
	
	// MARK: Outlets
	
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: ViewController Lifecycle Methods
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Trending"
			
		configureRefreshControl()
		setupBindings()
		viewModel.fetchFirstPage()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if viewModel.isSkeletonViewAvailable {
			tableView.showAnimatedGradientSkeleton()
		}
	}
	
	func setupBindings() {
		viewModel.reposListBinder.updateHandler = { _ in
			self.handleDataUpdate()
		}
		viewModel.isRefreshing.updateHandler = { showLoader in
			if !showLoader {
				self.refreshControl.endRefreshing()
			}
		}
	}
	
	@objc
	func fetchLatestData() {
		viewModel.refreshData()
	}
	
}

// MARK: - Private Methods

private extension TrendingReposViewController {
	
	func handleDataUpdate() {
		if viewModel.isSkeletonViewAvailable {
			viewModel.isSkeletonViewAvailable = false
			tableView.isSkeletonable = false
			tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(3))
		} else {
			tableView.reloadData()
		}
	}
	
	func configureRefreshControl() {
		refreshControl.tintColor = Color.primaryColor
		tableView.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(fetchLatestData), for: .valueChanged)
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
		return viewModel.repoObjects.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TrendingRepoTableViewCell.reuseIdentifier,
												 for: indexPath) as! TrendingRepoTableViewCell
		cell.setRepo(viewModel.repoObjects[indexPath.row])
		return cell
	
	}
	
}

// MARK: - UITableViewDelegate Methods

extension TrendingReposViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		UIView.animate(withDuration: 0.3) {
			tableView.performBatchUpdates(nil)
		}
	}

}
