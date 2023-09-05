//
//  ModelArticle.swift
//  LoginData
//
//  Created by apple on 02/09/23.
//

import Foundation
import UIKit

struct ArticleData: Decodable {
    let title  : String?
    let author : String?
    let description : String?
    let publishedAt : String?
    let content : String?
    let urlToImage : String?
}
struct NewsData: Decodable{
    let articles : [ArticleData]
   
}


