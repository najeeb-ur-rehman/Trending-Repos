//
//  RepoListResponse.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 03/10/2021.
//

import Foundation
import ObjectMapper

struct RepoListResponse: Mappable {
	
	var totalCount: Int?
	var items: [Repo]?
	
	init?(map: Map) {}
	
	 init(totalCount: Int? = nil, items: [Repo]? = nil) {
		self.totalCount = totalCount
		self.items = items
	}
	
	mutating func mapping(map: Map) {
		totalCount <- map["total_count"]
		items <- map["items"]
	}
	
}
