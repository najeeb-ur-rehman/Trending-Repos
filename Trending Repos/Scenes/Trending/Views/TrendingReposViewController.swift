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
	
	private lazy var loadingFooterView: UIView = {
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
	
	@IBOutlet weak var emptyDataView: EmptyDataView!
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: ViewController Lifecycle Methods
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = "Trending"
		
		setupBindings()
		viewModel.fetchFirstPage()
		initialSetup()
		
		tableView.showAnimatedSkeleton()
	}
	
	@objc
	func fetchLatestData() {
		viewModel.refreshData()
	}
	
	@objc
	func retryButtonHandler() {
		setSkeletonViewAvailableStatus(true)
		tableView.showAnimatedSkeleton()
		showEmptyViewIfNecessary()
		viewModel.refreshData()
	}
	
}

// MARK: - Private Methods

private extension TrendingReposViewController {
	
	func initialSetup() {
		tableView.configureRefreshControlWithTarget(self, andSelector: #selector(fetchLatestData))
		viewModel.isNextPageFetching.value = false
		emptyDataView.retryButton.addTarget(self,
											action: #selector(retryButtonHandler),
											for: .touchUpInside)
	}
	
	func setupBindings() {
		viewModel.reposListBinder.updateHandler = { _ in
			DispatchQueue.main.async {
				self.handleDataUpdate()
			}
		}
		viewModel.isRefreshing.updateHandler = { showLoader in
			if !showLoader {
				DispatchQueue.main.async {
					self.tableView.endRefreshing()
				}
			}
		}
		viewModel.isNextPageFetching.updateHandler = { isFetching in
			DispatchQueue.main.async {
				let footerView: UIView = isFetching ? self.loadingFooterView : UIView()
				self.tableView.tableFooterView = footerView
			}
		}
		viewModel.showError.updateHandler = { errorMessage in
			DispatchQueue.main.async {
				Utils.showOkAlert(title: "Error", message: errorMessage, viewController: self)
			}
		}
	}
	
	func handleDataUpdate() {
		if viewModel.isSkeletonViewAvailable {
			setSkeletonViewAvailableStatus(false)
			tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(3))
		} else {
			tableView.reloadData()
		}
		showEmptyViewIfNecessary()
	}
	
	func showEmptyViewIfNecessary() {
		let showEmptyDataView = !viewModel.isSkeletonViewAvailable && viewModel.repoObjects.isEmpty
		emptyDataView.isHidden = !showEmptyDataView
		tableView.isHidden = showEmptyDataView
	}
	
	func setSkeletonViewAvailableStatus(_ available: Bool) {
		viewModel.isSkeletonViewAvailable = available
		tableView.isSkeletonable = available
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
		let shouldFetch = contentHeight > 0 && contentHeight - actualPosition <= 20 && viewModel.canFetch && viewModel.isNextPageAvailable
		if shouldFetch {
			viewModel.fetchNextPage()
		}
	}

}
