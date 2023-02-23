//
//  ArticlesModel.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 11/13/22.
//

import Foundation

struct TopStories: Codable {
    let articles: [Articles]?
    
    enum CodingKeys: String, CodingKey {
        case articles = "results"
    }
}

struct Articles: Codable {
    let urlImages: [UrlImage]?
    let title: String?
    let publishedDate: String?
    let articleUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case urlImages     = "multimedia"
        case title         = "title"
        case publishedDate = "published_date"
        case articleUrl    = "url"
    }
    
    func getLargeThumbnailUrl()-> String? {
        if let image = urlImages?.last {
            return image.url
        }
        return nil
    }
}
    
struct UrlImage: Codable {
    let url: String?
    let format: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case format = "format"
    }
}
