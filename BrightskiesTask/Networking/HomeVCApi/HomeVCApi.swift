//
//  HomeVCApi.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 22/08/2023.
//

import Foundation

class HomeApi : BaseAPI<HomeNetworking>{
 
    func getRecipe(completion: @escaping (Result<HomeData,NetworkError>)->Void){
         self.fetshData(target: .getData, responceClass: HomeData.self) {
            (response) in 
            switch response {
            case .success(let data):
                if let data = data {
                    completion(.success(data))
                }else{
                    completion(.failure(.cantParseData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
