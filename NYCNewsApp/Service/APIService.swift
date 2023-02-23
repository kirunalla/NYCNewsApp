//
//  APISerivce.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 11/13/22.
//

import Foundation

class APIService {
    
    private init(){ }
    
    static var sharedService = APIService()
    
    func getTopStories(section: String = "") async throws -> [Articles]? {
        let url = URL(string: AppConstants.shared.baseUrl + "svc/topstories/v2/" + section + ".json?api-key=" + AppConstants.shared.apiKey)!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let topStories = try JSONDecoder().decode(TopStories.self, from: data)
        return topStories.articles
    }
}
