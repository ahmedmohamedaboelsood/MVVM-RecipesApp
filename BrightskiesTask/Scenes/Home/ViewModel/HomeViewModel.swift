//
//  HomeVcViewModel.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 22/08/2023.
//

import Foundation

protocol HomeViewModelDelegate{
    func requestFail(error : NetworkError)
}

class HomeViewModel {
    
    //MARK: - Variables
    var isLoading : Observable<Bool> = Observable(false)
    var cellDataSourse : Observable<[HomeCellViewModel]> = Observable(nil)
    var dataSourse : HomeData?
    var homeApi = HomeApi()
    var delegate : HomeViewModelDelegate?
    //MARK: - TABLEVIEW
    func numberOfsections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int)->Int{
        dataSourse?.count ?? 0
    }
    //MARK: - Functions
    func getData(){
        isLoading.value = true
        homeApi.getRecipe { result in
            self.isLoading.value = false
            switch result{
            case .success(let data):
                self.dataSourse = data
                dump(self.dataSourse?.compactMap({HomeCellViewModel($0)}))
                self.mapData()
            case .failure(let fail):
                self.delegate?.requestFail(error: fail)
                switch fail{
                case .urlError:
                    print("url")
                case .cantParseData:
                    print("parse")
                case .not200:
                    print("200")
                case .internetConnection:
                    print("internet")
                }
            }
        }
    }
    
    func setRecipeRate(_ recipe : HomeDataModel) -> String{
        guard let rating = recipe.rating else {
            return "N/A"
        }
        return "\(rating)"
    }
    
    func mapData(){
        self.cellDataSourse.value = self.dataSourse?.compactMap({HomeCellViewModel($0)})
    }
}
