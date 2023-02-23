//
//  DetailedViewController.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 1/9/23.
//

import UIKit
import WebKit

class DetailedViewController: UIViewController {
    @IBOutlet var wkWebView: WKWebView?
    var articleUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let articleUrl = articleUrl, let url = URL(string: articleUrl) {
            let urlRequest = URLRequest(url: url)
            wkWebView?.load(urlRequest)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
