//
//  Repo.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import Foundation
import ObjectMapper

struct Repo: Mappable {
	
	var name: String?
	var description: String?
	var stars: Int?
	var language: String?
	var user: User?
	
	init(name: String, description: String, stars: Int, language: String, user: User?) {
		self.name = name
		self.description = description
		self.stars = stars
		self.language = language
		self.user = user
	}
	
	init?(map: Map) {}
	
	mutating func mapping(map: Map) {
		name <- map["name"]
		description <- map["description"]
		stars <- map["stargazers_count"]
		language <- map["language"]
		user <- map["owner"]
	}
	
	
}
