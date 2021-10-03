//
//  TrendingReposViewController.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 28/09/2021.
//

import UIKit
import SkeletonView

class TrendingReposViewController: UIViewController {
	
	var viewModel = TrendingRepoViewModel()
	
	lazy var loadingFooterView: UIView = {
		let indicator = UIActivityIndicatorView()
		indicator.tintColor = Color.primaryColor
		indicator.hidesWhenStopped = true
		indicator.startAnimating()
		indicator.frame = CGRect(x: UIScreen.main.bounds.width/2 - 10, y: 15, width: 20, height: 20)
		
		let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
		view.addSubview(indicator)
		return view
	}()
	
	// MARK: Outlets
	
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: ViewController Lifecycle Methods
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Trending"
			
		tableView.configureRefreshControlWithTarget(self, andSelector: #selector(fetchLatestData))
		setupBindings()
		viewModel.fetchFirstPage()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if viewModel.isSkeletonViewAvailable {
			tableView.showAnimatedGradientSkeleton()
		}
	}
	
	@objc
	func fetchLatestData() {
		viewModel.refreshData()
	}
	
}

// MARK: - Private Methods

private extension TrendingReposViewController {
	
	func setupBindings() {
		viewModel.reposListBinder.updateHandler = { _ in
			self.handleDataUpdate()
		}
		viewModel.isRefreshing.updateHandler = { showLoader in
			if !showLoader {
				self.tableView.endRefreshing()
			}
		}
		viewModel.isNextPageFetching.updateHandler = { isFetching in
			let footerView: UIView = isFetching ? self.loadingFooterView : UIView()
			self.tableView.tableFooterView = footerView
		}
	}
	
	func handleDataUpdate() {
		if viewModel.isSkeletonViewAvailable {
			viewModel.isSkeletonViewAvailable = false
			tableView.isSkeletonable = false
			tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(3))
		} else {
			tableView.reloadData()
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
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let actualPosition = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height - scrollView.frame.size.height
		if contentHeight > 0 && contentHeight - actualPosition <= 20 && !viewModel.isFetching {
			viewModel.fetchNextPage()
		}
	}

}
