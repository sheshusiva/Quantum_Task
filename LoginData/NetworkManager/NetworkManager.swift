//
//  NetworkManager.swift
//  LoginData
//
//  Created by apple on 02/09/23.
//

import Foundation
import UIKit
import Alamofire

class NetWorkManger {
    
    static var shared = NetWorkManger()
    private init() {}
    
    func getDataFromServerMethod(sucess: @escaping([NewModel])-> (), failure: @escaping(String)-> ()) {
        
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-08-05&sortBy=publishedAt&apiKey=110aacefd5384026bb840b03bb3a7457")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            guard let data = data, error == nil else
            {
                print("Error Occured While Acessing Data with URL")
                return
            }
            do{
                let newFullList = try JSONDecoder().decode(NewsData.self, from: data)
                 for newsArticles in newFullList.articles {
                     CoreDataManager.sharedInstance.saveNewsDetails(articleData: newsArticles)
                 }
                 DispatchQueue.main.async {
                     sucess(CoreDataManager.sharedInstance.getNewsData())
                 }
            }
            catch{
                print("Error Occured While Decoding JSON into Swift Structure \(error)")
                failure(error.localizedDescription)
            }
        })
        dataTask.resume()
    }
    
}
