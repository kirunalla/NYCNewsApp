//
//  ArticlesViewController.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 11/13/22.
//
import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var searchBar: UISearchBar?
    @IBOutlet var textField: UITextField?
    
    var articlesViewModel: ArticlesViewModel? = nil
    
    var sections: [String]? = nil
    var articles: [Articles]? = nil
    var results: [Articles]? = nil
    var selectedArticleUrl: String? = nil
    var searchArticlesWorkItem: DispatchWorkItem? = nil
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        textField?.text = ""
        
        textField?.addTarget(self, action: #selector(textFieldTouched), for: .touchDown)
        tableView?.dataSource = self
        tableView?.delegate = self
        searchBar?.delegate = self
        articlesViewModel = ArticlesViewModel()
        
        Task {
            sections = await articlesViewModel?.fetchArticlesSections()
            if let sections = sections, !sections.isEmpty {
                populateArticles(article: sections[0])
            }
        }
        
        /*articlesViewModel?.bindArticlesData = { values in
            if let articles = values as? [Articles] {
                self.results = articles
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
            else if let sections = values as? [String] {
                
            }
        }
        articlesViewModel?.fetchArticlesSections()
        articlesViewModel?.fetchTopStories()*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailedVC = segue.destination as? DetailedViewController {
            print("in category")
            detailedVC.articleUrl = selectedArticleUrl
        }
        else if let categoryVC = segue.destination as? CategoryTableViewController {
            print("in category")
            categoryVC.providesPresentationContextTransitionStyle = false
            categoryVC.definesPresentationContext = true
            categoryVC.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
            categoryVC.view.backgroundColor = UIColor.clear
            categoryVC.sections = sections
        }
        
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewYorkTimesTableViewCell", for: indexPath) as! NewYorkTimesTableViewCell
        if let articles = results {
            let article = articles[indexPath.row]
            cell.articleTitle?.text = article.title
            
            if let publishedDate = article.publishedDate { cell.publishedDate?.text = articlesViewModel?.formatPublishedDate(date: publishedDate)
            }
            
            cell.articleImage?.layer.borderColor = UIColor.gray.cgColor
            cell.articleImage?.layer.borderWidth = 3.0
            cell.articleImage?.layer.cornerRadius = 10.0
            
            if let url = article.getLargeThumbnailUrl() {
                cell.articleImage?.loadWithImageUrl(imageUrl: url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let articles = results {
            let article = articles[indexPath.row]
            selectedArticleUrl = article.articleUrl
        }
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailedVC = storyboard.instantiateViewController(withIdentifier: "detailedVC")
        self.present(detailedVC, animated: true)*/
    }
}

extension ArticlesViewController {
    func seperatingDateFromPublishedDate(publishedDate: String)-> String? {
        return String(publishedDate.prefix(10))
    }
    
    @objc func textFieldTouched(textField: UITextField) {
        performSegue(withIdentifier: "SegueCategoryViewContoller", sender: self)
    }
}

/*extension ArticlesViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isTouchInside == true {
        performSegue(withIdentifier: "SegueCategoryViewContoller", sender: self)
        }
    }
}*/

extension ArticlesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchArticlesWorkItem?.cancel()
        searchArticlesWorkItem = DispatchWorkItem {
            self.results = self.searchArticlesByTitle(searchText)
            if searchText == "" {
                self.results = self.articles
            }
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
        if let searchArticlesWorkItem = searchArticlesWorkItem {
            DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(250), execute: searchArticlesWorkItem)
        }
    }
    
    func searchArticlesByTitle(_ title: String)-> [Articles]? {
        let results = articles?.filter({ article in
            print("article -> \(article.title?.count)")
            
            return article.title?.contains(title) ?? false
        })
        return results
    }
}

extension ArticlesViewController {
    
    /*func filterNames(article: [Articles]) {
        article.filter { article in
            <#code#>
        }
    }*/
    func populateArticles(article: String = "") {
        textField?.text = article
        Task {
            articles = await articlesViewModel?.fetchTopStories(category: article)
            self.results = articles
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
}
