//
//  ReposDataRepository.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 03/10/2021.
//

import Foundation
import ObjectMapper

typealias RepoResult = Result<RepoListResponse, TrendingRepoError>

class ReposDataRepository {
	
	private let client = APIClient.shared
	
	func getReposPage(_ pageNo: Int, withCompletion completion: @escaping (RepoResult) -> Void) {
		let request = RepoRequest.searchRepos(pageNo: pageNo)
		client.performRequest(request) { (result) in
			switch result {
			case .success(let json):
				guard let reposListResponse = Mapper<RepoListResponse>().map(JSONObject: json) else {
					completion(.failure(.custom("Parse error")))
					return
				}
				completion(.success(reposListResponse))
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
}

enum RepoRequest: HTTPRequest {
	
	case searchRepos(pageNo: Int)
	
}

extension RepoRequest {
	
	var endPoint: URL? {
		switch self {
		case .searchRepos(let page):
			return URL(string: "https://api.github.com/search/repositories?q=language=+sort:stars&page=\(page)/")
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .searchRepos:
			return .GET
		}
	}
	
}
