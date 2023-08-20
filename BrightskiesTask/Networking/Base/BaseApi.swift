//
//  BaseApi.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 20/08/2023.
//

import Foundation
import Alamofire

enum NetworkError : Error{
    case urlError
    case cantParseData
    case not200
    case internetConnection
}

class BaseAPI<T:TargetType>{
    var connectionState : String?
    func fetshData<M:Decodable>(target:T,responceClass:M.Type,completion:@escaping(Result<M?,NetworkError>)->Void){
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)
        let urlString = target.baseURL + target.path
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            connectionState = "success"
        }else{
            completion(.failure(.internetConnection))
            connectionState = nil
        }
        guard let connectionState = connectionState else {return}
        
        guard let encodedURLString =  urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedURL = URL(string: encodedURLString) else {
            print("Invalid URL")
            return
        }
        AF.request(encodedURL , method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseDecodable(of:M.self){ response in
            print(target.baseURL + target.path)
            
            guard let statusCode =
                    response.response?.statusCode else {
                
                completion(.failure(.urlError))
                return
            }
            if statusCode == 200 {
                switch response.result{
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    completion(.failure(.cantParseData))
                }
            }else if (400...499).contains(statusCode){
                completion(.failure(.urlError))
            }else{
                completion(.failure(.not200))
            }
        }
    }
    
    private func buildParams(task : Task)->([String:Any],ParameterEncoding){
        switch task{
        case .requestPlain:
            return ([:],URLEncoding.default)
        case .requestParameters(parameter: let parametes, encoding: let encoding):
            return (parametes,encoding)
        }
    }
}
