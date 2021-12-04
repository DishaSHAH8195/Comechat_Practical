//
//  NewsFeedModel.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//

import Foundation

// MARK: - NewsFeedModel
class NewsFeedModel: Codable {
    var status      : String?
    var totalResults: Int?
    var articles    : [Article]?
}

// MARK: - Article
class Article: Codable {
    var author                   : String?
    var title, articleDescription: String?
    var url                      : String?
    var urlToImage               : String?
    var publishedAt              : String?
    var content                  : String?
    
    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
