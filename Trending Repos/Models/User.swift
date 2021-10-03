//
//  User.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import Foundation
import ObjectMapper

struct User: Mappable {
	
	var name: String?
	var avatarUrl: URL?
	
	init?(map: Map) {}
	
	mutating func mapping(map: Map) {
		name <- map["login"]
		avatarUrl <- (map["avatar_url"], URLTransform())
	}
	
}
