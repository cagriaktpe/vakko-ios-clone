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
    var dateCreated: Date
    
    init(commentId: String, authorId: String, productId: String, authorName: String, title: String, comment: String, rating: Int, dateCreated: Date) {
        self.commentId = commentId
        self.authorId = authorId
        self.productId = productId
        self.authorName = authorName
        self.title = title
        self.comment = comment
        self.rating = rating
        self.dateCreated = dateCreated
    }
    
    // coding keys
    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case authorId = "author_id"
        case productId = "product_id"
        case authorName = "author_name"
        case title
        case comment
        case rating
        case dateCreated = "date_created"
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
        try container.encode(dateCreated, forKey: .dateCreated)
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
        dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    }
}

extension CommentModel {
    static let mock1 = CommentModel(commentId: "1", authorId: "1", productId: "1", authorName: "Samet Çağrı Aktepe", title: "Başlık", comment: "Yorum", rating: 5, dateCreated: Date())
    static let mock2 = CommentModel(commentId: "2", authorId: "2", productId: "1", authorName: "Furkan Aktepe", title: "Başlık", comment: "Yorum", rating: 3, dateCreated: Date())
    static let mock3 = CommentModel(commentId: "3", authorId: "3", productId: "1", authorName: "Alperen Aktepe", title: "Başlık", comment: "Yorum", rating: 1, dateCreated: Date())
    
    static let mockArray = [mock1, mock2, mock3]
}
