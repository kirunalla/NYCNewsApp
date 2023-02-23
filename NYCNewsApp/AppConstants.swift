//
//  AppConstants.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 11/14/22.
//

import Foundation

class AppConstants {
    static let shared = AppConstants()
    
    let baseUrl = "https://api.nytimes.com/"
    let apiKey  = "QEgEUVhSk9MVZGdnonCjYXGMcGscfbYM"
    var sections = ["arts", "automobiles", "books", "business"]
}
