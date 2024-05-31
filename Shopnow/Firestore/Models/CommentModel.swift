//
//  CommentModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import Foundation

struct CommentModel: Codable, Hashable {
    var commentId: String
    var authorId: String
    var productId: String
    var authorName: String
    var title: String
    var comment: String
    var rating: Int
    
    // coding keys
    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case authorId = "author_id"
        case productId = "product_id"
        case authorName = "author_name"
        case title
        case comment
        case rating
    }
    
    // encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(commentId, forKey: .commentId)
        try container.encode(authorId, forKey: .authorId)
        try container.encode(productId, forKey: .productId)
        try container.encode(authorName, forKey: .authorName)
        try container.encode(title, forKey: .title)
        try container.encode(comment, forKey: .comment)
        try container.encode(rating, forKey: .rating)
    }
    
    // decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        commentId = try container.decode(String.self, forKey: .commentId)
        authorId = try container.decode(String.self, forKey: .authorId)
        productId = try container.decode(String.self, forKey: .productId)
        authorName = try container.decode(String.self, forKey: .authorName)
        title = try container.decode(String.self, forKey: .title)
        comment = try container.decode(String.self, forKey: .comment)
        rating = try container.decode(Int.self, forKey: .rating)
    }
}
