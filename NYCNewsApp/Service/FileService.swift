//
//  FileService.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 1/22/23.
//

import Foundation

class FileService {
    
    private init(){ }
    
    static let shared = FileService()
    
    func getContents(fileName: String) async throws -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist")
        {
            return FileManager.default.contents(atPath: path)
        }
        return nil
    }
}
