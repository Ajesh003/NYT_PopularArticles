

import Foundation

import UIKit

typealias CompletionBlock = () -> Void

class MostPopularArticleVM {

    private var datasource: [MPAModel] = []
    var refreshUI: CompletionBlock?
    var numberOfRows: Int {
        return datasource.count
    }
    
    init(articles: [MPAModel]?) {
        if let alreadyGivenArticles = articles {
            datasource = alreadyGivenArticles
        } else {
            getAllMostPopularArticles()
        }
    }
    
    func getAllMostPopularArticles() {

        MPAService.getMostPopularArticles() { [weak self] (responseModel, error) in
            if error != nil {
            
                return
            }
            self?.datasource = responseModel?.results ?? []
            self?.refreshUI?()
        }
    }
    func articleForIndex(index: Int) -> MPAModel {
        return datasource[index]
    }
}
