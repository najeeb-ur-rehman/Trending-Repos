//
//  Repo.swift
//  Trending Repos
//
//  Created by Najeeb VenD on 02/10/2021.
//

import Foundation

struct Repo {
	
	var id: Int?
	var name: String?
	var description: String?
	var stars: Int?
	var language: String?
	var user: User?
	
}


extension Repo {
	
	static var dummyData: [Repo] {
			return [
				Repo(id: 0, name: "Swift", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User1", avatarUrl: "https://avatars.githubusercontent.com/u/10639145?v=4")),
				Repo(id: 0, name: "Swift2", description: "Apple's Swift language", stars: 14927, language: "C", user: User(id: 0, name: "User2", avatarUrl: "https://avatars.githubusercontent.com/u/4314092?v=4")),
				Repo(id: 0, name: "Swift3", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User2", avatarUrl: nil)),
				Repo(id: 0, name: "Swift4", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User3", avatarUrl: nil)),
				Repo(id: 0, name: "Swift5", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User4", avatarUrl: nil)),
				Repo(id: 0, name: "Swift6", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User5", avatarUrl: nil)),
				Repo(id: 0, name: "Swift7", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User6", avatarUrl: nil)),
				Repo(id: 0, name: "Swift8", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User7", avatarUrl: nil)),
				Repo(id: 0, name: "Swift9", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User8", avatarUrl: nil)),
				Repo(id: 0, name: "Swift", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User1", avatarUrl: "https://avatars.githubusercontent.com/u/10639145?v=4")),
				Repo(id: 0, name: "Swift2", description: "Apple's Swift language", stars: 14927, language: "C", user: User(id: 0, name: "User2", avatarUrl: "https://avatars.githubusercontent.com/u/4314092?v=4")),
				Repo(id: 0, name: "Swift3", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User2", avatarUrl: nil)),
				Repo(id: 0, name: "Swift4", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User3", avatarUrl: nil)),
				Repo(id: 0, name: "Swift5", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User4", avatarUrl: nil)),
				Repo(id: 0, name: "Swift6", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User5", avatarUrl: nil)),
				Repo(id: 0, name: "Swift7", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User6", avatarUrl: nil)),
				Repo(id: 0, name: "Swift8", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User7", avatarUrl: nil)),
				Repo(id: 0, name: "Swift9", description: "Apple's Swift language", stars: 14927, language: "Swift", user: User(id: 0, name: "User8", avatarUrl: nil))
			]
		}

}
