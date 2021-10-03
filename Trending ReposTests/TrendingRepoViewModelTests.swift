//
//  TrendingRepoViewModelTests.swift
//  Trending ReposTests
//
//  Created by Najeeb VenD on 04/10/2021.
//

import XCTest
@testable import Trending_Repos

class TrendingRepoViewModelTests: XCTestCase {

	let reposList = [
		Repo(name: "Repo1", description: "Description1", stars: 1, language: "1", user: nil),
		Repo(name: "Rep02", description: "Description2", stars: 2, language: "2", user: nil)
	]
	
	func test_initialState() {
		let reposDataProvider = MockedReposDataRepository()
		let sut = TrendingRepoViewModel()
		sut.reposProvider = reposDataProvider
		
		XCTAssertTrue(sut.isSkeletonViewAvailable)
		XCTAssertTrue(sut.canFetch)
		XCTAssertTrue(sut.isNextPageAvailable)
		XCTAssertFalse(sut.isNextPageFetching.value)
		XCTAssertFalse(sut.isRefreshing.value)
	}
	
	func test_restrictFetch_IfAlreadyFetching() {
		let firstFetchExpectation = XCTestExpectation(description: "FetchFirstPageExpectation")
		let reposDataProvider = MockedReposDataRepository()
		reposDataProvider.dataHandler = { () -> RepoResult in
			firstFetchExpectation.fulfill()
			let repoResponse = RepoListResponse(totalCount: 2, items: self.reposList)
			return .success(repoResponse)
		}
		let sut = TrendingRepoViewModel()
		sut.reposProvider = reposDataProvider
		
		XCTAssertTrue(sut.canFetch)
		XCTAssertTrue(sut.repoObjects.isEmpty)
		
		sut.fetchFirstPage()
		
		XCTAssertFalse(sut.canFetch)
		
		wait(for: [firstFetchExpectation], timeout: 2)
		
		XCTAssertTrue(sut.canFetch)
		XCTAssertTrue(sut.repoObjects.count == 2)
	}
	
	func test_refreshData() {
		let refreshExpectation = XCTestExpectation(description: "RefreshExpectation")
		let reposDataProvider = MockedReposDataRepository()
		reposDataProvider.dataHandler = { () -> RepoResult in
			refreshExpectation.fulfill()
			let repoResponse = RepoListResponse(totalCount: 2, items: self.reposList)
			return .success(repoResponse)
		}
		let sut = TrendingRepoViewModel()
		sut.reposProvider = reposDataProvider
		
		XCTAssertFalse(sut.isRefreshing.value)
		
		sut.refreshData()
		
		XCTAssertTrue(sut.isRefreshing.value)
		
		wait(for: [refreshExpectation], timeout: 2)
		
		XCTAssertFalse(sut.isRefreshing.value)
		
	}
	
	func test_nextPageFetch_noAvailablePageAfterFetch() {
		let nextPageExpectation = XCTestExpectation(description: "FetchNextPageExpectation")
		let reposDataProvider = MockedReposDataRepository()
		reposDataProvider.dataHandler = { () -> RepoResult in
			nextPageExpectation.fulfill()
			let repoResponse = RepoListResponse(totalCount: 2, items: self.reposList)
			return .success(repoResponse)
		}
		let sut = TrendingRepoViewModel()
		sut.reposProvider = reposDataProvider
		
		XCTAssertTrue(sut.isNextPageAvailable)

		sut.fetchNextPage()

		wait(for: [nextPageExpectation], timeout: 2)

		XCTAssertFalse(sut.isNextPageAvailable)

	}
	
	func test_nextPageFetch_availablePageEvenAfterFetch() {
		let nextPageExpectation = XCTestExpectation(description: "FetchNextPageExpectation")
		let reposDataProvider = MockedReposDataRepository()
		reposDataProvider.dataHandler = { () -> RepoResult in
			var repos = [Repo]()
			for _ in 1...16 {
				repos.append(contentsOf: self.reposList)
			}
			let repoResponse = RepoListResponse(totalCount: 32, items: repos)
			nextPageExpectation.fulfill()
			return .success(repoResponse)
		}
		let sut = TrendingRepoViewModel()
		sut.reposProvider = reposDataProvider
		
		XCTAssertTrue(sut.isNextPageAvailable)

		sut.fetchNextPage()

		wait(for: [nextPageExpectation], timeout: 2)

		XCTAssertTrue(sut.isNextPageAvailable)

	}

}


class MockedReposDataRepository: ReposDataRepository {
	
	var dataHandler: (() -> RepoResult)?
	
	override func getReposPage(_ pageNo: Int, withCompletion completion: @escaping (RepoResult) -> Void) {
		DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
			let repos = self.dataHandler?() ?? .failure(.custom("Something went wrong"))
			completion(repos)
		}
	}
}
