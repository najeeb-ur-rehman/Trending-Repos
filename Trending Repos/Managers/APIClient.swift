//
//  APIClient.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 03/10/2021.
//

import Foundation

enum HTTPMethod: String {
	case GET
	case POST
	case PUT
	case DELETE
}

enum TrendingRepoError: Error {
	case badURL
	case custom(_ message: String)
}

protocol HTTPRequest {
	
	var endPoint: URL? { get }
	
	var method: HTTPMethod { get }
	
	var parameters: [String : Any]? { get }
	
	var headers: [String : String]? { get }
	
}

extension HTTPRequest {
	
	var parameters: [String : Any]? { nil }
	
	var headers: [String : String]? { nil }
}

typealias APIClientResult = Result<Any, TrendingRepoError>

class APIClient {
	
	
	// MARK: - Class Instances
	
	static let shared = APIClient()
	
	
	// MARK: - Initializers
	
	private init() {}
	
	
	// MARK: - Public Methods
	
	func performRequest(_ request: HTTPRequest, withCompletion completion: @escaping (APIClientResult) -> Void) {
		guard let endpoint = request.endPoint else {
			completion(.failure(.badURL))
			return
		}
		var urlRequest = URLRequest(url: endpoint)
		urlRequest.httpMethod = request.method.rawValue
		let body = try? JSONSerialization.data(withJSONObject: request.parameters ?? [], options: .prettyPrinted)
		urlRequest.httpBody = body

		var headers = urlRequest.allHTTPHeaderFields
		request.headers.map {
			headers = headers?.merging($0) { (current, _) in current }
		}
		urlRequest.allHTTPHeaderFields = request.headers
		
		URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
			if let error = error {
				completion(.failure(.custom(error.localizedDescription)))
				return
			}
			
			guard let data = data,
				  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
				completion(.failure(.custom("Unable to parse json data")))
				return
			}
			completion(.success(json))
			
		}.resume()
		
	}
	
	
}

