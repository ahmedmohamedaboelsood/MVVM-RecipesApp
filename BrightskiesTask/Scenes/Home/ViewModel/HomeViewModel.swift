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
            }
        }
    }
    
    func mapData(){
        self.cellDataSourse.value = self.dataSourse?.compactMap({HomeCellViewModel($0)})
    }
    
    func retrieMovie(recipeID : String) -> HomeDataModel? {
        guard let remoteMovie = dataSourse?.first(where:{$0.id == recipeID}) else {return nil}
        return remoteMovie
    }
}
