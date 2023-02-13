//
//  ServiceHelper.swift
//  Sample
//
//  Created by Admin on 10/02/23.
//

import Foundation

        
// https://api.nasa.gov/planetary/apod?api_key=dMyt8fIlUlUdhYcKXhNZCfjvfczvlt8cJbjOXh u0&count=10


// API URLS

let APIKey = "dMyt8fIlUlUdhYcKXhNZCfjvfczvlt8cJbjOXhu"
let kAPIPeriods: Int = 10
let API_BASE_URL = "https://api.nasa.gov/planetary/apod"
let NEWS_API_URL = API_BASE_URL + "?api_key==\(APIKey)" + "count==\(kAPIPeriods)"

protocol ServiceHelperProtocol : class {
    func fetchArticles(_ completion: @escaping ((Result<ArticlesData, ErrorResult>) -> Void))
}

final class ServiceHelper : GenericAPIClient, ServiceHelperProtocol {
    
    
    static let shared = ServiceHelper()
    
    let apiUrlStr = NEWS_API_URL
    var task : URLSessionTask?
    
    func fetchArticles(_ completion: @escaping ((Result<ArticlesData, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchArticles()
        task = APIClient().loadData(urlString: apiUrlStr, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchArticles() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
