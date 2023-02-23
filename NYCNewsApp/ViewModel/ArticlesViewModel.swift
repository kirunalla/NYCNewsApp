//
//  ArticlesViewModel.swift
//  NYCNewsApp
//
//  Created by veeramani ganesan on 1/16/23.
//

import Foundation

class ArticlesViewModel {
    
    //var bindArticlesData: ((Any?)->())? = nil
    //var taskObj: Task<(), Never>? = nil
//extension ArticlesViewModel {
    //Async/Await
    var obj: ArticlesViewController? = nil
    
    func fetchArticlesSections() async -> [String]? {
        var sections: [String]? = nil
        do {
            if let data = try await FileService.shared.getContents(fileName: "ArticlesSections") {
                sections = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String]
            }
        } catch {
                print("fetchArticlesSections - Exception")
        }
        return sections
    }
     
    func fetchTopStories(category: String = "") async -> [Articles]? {
        var topStories: [Articles]? = nil
        do {
            topStories = try await APIService.sharedService.getTopStories(section: category)
        }
        catch {
            print("fetchTopStories - Exception")
        }
        return topStories
     }
    
    /*func fetchArticlesSections() {
        taskObj = Task {
            do {
                if let data = try await FileService.shared.getContents(fileName: "ArticlesSections") {
                    let sections = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String]
                    bindArticlesData?(sections)
                }
            } catch {
                    print("fetchArticlesSections - Exception")
            }
       }
    }
    
    func fetchTopStories() {
         taskObj = Task {
            do {
                let topStories = try await APIService.sharedService.getTopStories(section: "Arts")
                bindArticlesData?(topStories)
            }
            catch {
                print("fetchTopStories - Exception")
            }
        }
    }*/
    
    func formatPublishedDate(date: String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let dateObj = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateStr = dateFormatter.string(from: dateObj!)
        return dateStr
    }
}
