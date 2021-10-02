//
//  TrendingReposViewControllerTests.swift
//  Trending ReposTests
//
//  Created by Najeeb VenD on 30/09/2021.
//

import XCTest
@testable import Trending_Repos

class TrendingReposViewControllerTests: XCTestCase {

	// SUT: System Under Test
	func makeSUT() throws -> TrendingReposViewController {
		let bundle = Bundle(for: TrendingReposViewController.self)
		let storyboard = UIStoryboard(name: UIStoryboard.Name.Main.rawValue, bundle: bundle)
		
		let initialVC = storyboard.instantiateInitialViewController()
		let navigationCtrl = try XCTUnwrap(initialVC as? UINavigationController)
		
		let trendingVC = try XCTUnwrap(navigationCtrl.topViewController as? TrendingReposViewController)
		return trendingVC
	}
	
	func test_initialViewController_init() throws {
		_ = try makeSUT()
	}
	
	func test_set_title() throws {
		let sut = try makeSUT()
		sut.loadViewIfNeeded()
		XCTAssertEqual(sut.title, "Trending")
	}

	func test_tableView_configuration() throws {
		let sut = try makeSUT()
		sut.loadViewIfNeeded()
		
		XCTAssertNotNil(sut.tableView.delegate)
		XCTAssertNotNil(sut.tableView.dataSource)
	}
	
	func test_cell_expansionAndCollapsion() throws {
		let sut = try makeSUT()
		sut.loadViewIfNeeded()
		
		guard sut.tableView.numberOfRows(inSection: 0) > 1 else {
			return
		}
		
		let indexPath0 = IndexPath(row: 0, section: 0)
		let indexPath1 = IndexPath(row: 1, section: 0)
		
		var cell0: TrendingRepoTableViewCell
		var cell1: TrendingRepoTableViewCell
		
		// MARK: Initial state
		
		cell0 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath0) as? TrendingRepoTableViewCell)
		cell1 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath1) as? TrendingRepoTableViewCell)
		
		XCTAssertFalse(cell0.isExpanded)
		XCTAssertFalse(cell1.isExpanded)
		
		// MARK: Case when cell-0 is tapped
		
		sut.tableView.selectRow(at: indexPath0, animated: false, scrollPosition: .none)
		
		cell0 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath0) as? TrendingRepoTableViewCell)
		cell1 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath1) as? TrendingRepoTableViewCell)
		
		XCTAssertTrue(cell0.isExpanded)
		XCTAssertFalse(cell1.isExpanded)
		
		// MARK: Case when cell-1 is tapped then the cell-1 should be expanded and cell-0 should be collapsed
		
		sut.tableView.selectRow(at: indexPath1, animated: false, scrollPosition: .none)
		
		cell0 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath0) as? TrendingRepoTableViewCell)
		cell1 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath1) as? TrendingRepoTableViewCell)
		
		XCTAssertFalse(cell0.isExpanded)
		XCTAssertTrue(cell1.isExpanded)
		
		// MARK: Case when cell-1 is already expanded and tapped it again then it should be collapsed as well
		
		sut.tableView.selectRow(at: indexPath1, animated: false, scrollPosition: .none)
		
		cell0 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath0) as? TrendingRepoTableViewCell)
		cell1 = try XCTUnwrap(sut.tableView.cellForRow(at: indexPath1) as? TrendingRepoTableViewCell)
		
		XCTAssertFalse(cell0.isExpanded)
		XCTAssertFalse(cell1.isExpanded)
		
	}
	
	
	
	
}
