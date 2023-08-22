//
//  HomeVCNetworking.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 22/08/2023.
//

enum HomeNetworking{
    case getData
}

extension HomeNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getData:
            return NetworkConstants.shared.serverAddress
        }
    }
    var path: String {
        switch self{
        case .getData:
            return NetworkConstants.shared.apiKey
        }
    }
    var method: HTTPMethod {
        switch self{
        case .getData:
            return .get
        }
    }
    var task: Task {
        switch self{
        case .getData:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
