//
//  NewsFeedViewModel.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//

import Foundation
import CoreData

class NewsFeedViewModel {
    var arrArticles: [Article] = []
}

extension NewsFeedViewModel {
    func getNewsArticle(completion: @escaping (_ error: String?) -> ()) {
        WebServiceHandler.apiRequestWithAnyParam(method: .get, urlString: WebServiceURL.getNewsFeed, parameters: [:], headerType: .xFormOnly, isShowLoader: true, shouldHideLoader: true, isEncodade: false, success: { [weak self] (response, statusCode)  in
            
            guard let dictResponse = response as? [String:Any] else { return }
            let objNewsFeedModel : NewsFeedModel = getObjectViaCodable(dict: dictResponse) ?? NewsFeedModel()
            
            //storing articles sorted by Author name
            self?.arrArticles = objNewsFeedModel.articles?.sorted{($0.author ?? "").localizedCaseInsensitiveCompare($1.author ?? "") == ComparisonResult.orderedAscending} ?? []
            completion(nil)
        }) { (errorResponse, err, statusCode, obj) in
            print("Error in network call")
            completion(obj.debugDescription)
        }
    }
}
