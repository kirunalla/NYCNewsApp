//
//  UIImageView+Extension.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 11/29/22.
//

import UIKit

extension UIImageView {
    
    func loadWithImageUrl(imageUrl: String) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: URL(string: imageUrl)!)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            catch {
                
            }
        }
    }
}
