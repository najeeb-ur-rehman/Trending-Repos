//
//  TrendingRepoViewModel.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import Foundation

class TrendingRepoViewModel {
	
	var reposListBinder = Bindable<[Repo]>([])
	var isRefreshing = Bindable<Bool>(false)
	var isNextPageFetching = Bindable<Bool>(false)
	var isFetching = false
	var isSkeletonViewAvailable = true
	
	
	var canFetch: Bool {
		!isFetching
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
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			self.isFetching = false
			completion(Repo.dummyData)
		}
	}
}
