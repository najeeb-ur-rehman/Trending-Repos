//
//  TrendingRepoViewModel.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import Foundation

class TrendingRepoViewModel {
	
	var reposProvider = ReposDataRepository()
	
	var reposListBinder = Bindable<[Repo]>([])
	var isRefreshing = Bindable<Bool>(false)
	var isNextPageFetching = Bindable<Bool>(false)
	var showError = Bindable<String>("Error")
	var isSkeletonViewAvailable = true
	
	private var totalItems = 0
	private var currentPage = 0
	private let itemsPerPage = 30
	private var isFetching = false
	
	var canFetch: Bool {
		!isFetching
	}
	
	var isNextPageAvailable: Bool {
		(totalItems / itemsPerPage) >= currentPage
	}
	
	var repoObjects: [Repo] {
		reposListBinder.value
	}
	
	func refreshData() {
		isRefreshing.value = true
		fetchFirstPage()
	}
	
	func fetchFirstPage() {
		guard canFetch else {
			return
		}
		fetchRepos { repos in
			if self.isRefreshing.value {
				self.isRefreshing.value = false
			}
			self.reposListBinder.value = repos
		}
	}
	
	func fetchNextPage() {
		guard canFetch else {
			return
		}
		isNextPageFetching.value = true
		fetchRepos { repos in
			self.isNextPageFetching.value = false
			self.reposListBinder.value.append(contentsOf: repos)
		}
	}
	
	private func fetchRepos(_ completion: @escaping ([Repo]) -> Void) {
		isFetching = true
		reposProvider.getReposPage(currentPage) { (result) in
			switch result {
			case .success(let repoResponse):
				self.currentPage += 1
				self.totalItems = repoResponse.totalCount ?? 0
				completion(repoResponse.items ?? [])
			case .failure(let error):
				self.showError.value = error.localizedDescription
			}
			self.isFetching = false
		}
	}
}
