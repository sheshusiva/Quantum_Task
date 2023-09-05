//
//  UserviewModel.swift
//  LoginData
//
//  Created by apple on 02/09/23.
//

import Foundation
import UIKit
class UserViewModel {
    
    func getNewsDetailsFromServer(sucess: @escaping([NewModel])-> (), failure: @escaping(String)-> ()) {
        
        NetWorkManger.shared.getDataFromServerMethod { newsArr in
            sucess(newsArr)
        } failure: { error in
            failure(error)
        }
    }
}
