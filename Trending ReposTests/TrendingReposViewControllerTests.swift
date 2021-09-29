//
//  TrendingReposViewControllerTests.swift
//  Trending ReposTests
//
//  Created by Najeeb VenD on 30/09/2021.
//

import XCTest
@testable import Trending_Repos

class TrendingReposViewControllerTests: XCTestCase {

	func test_Initial_ViewController_Init() throws {
		let bundle = Bundle(for: TrendingReposViewController.self)
		let storyboard = UIStoryboard(name: UIStoryboard.Name.Main.rawValue, bundle: bundle)
		
		let initialVC = storyboard.instantiateInitialViewController()
		let navigationCtrl = try XCTUnwrap(initialVC as? UINavigationController)
		
		_ = try XCTUnwrap(navigationCtrl.topViewController as? TrendingReposViewController)
	}

}
