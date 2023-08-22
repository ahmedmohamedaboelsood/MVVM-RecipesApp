//
//  HomeTableViewCellViewModel.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 22/08/2023.
//

import Foundation
 

class HomeCellViewModel {
    var id : String
    var name : String
    var time : String
    var rating : Double?
    var image : String
    
    init(_ recipe : HomeDataModel) {
        self.id = recipe.id
        self.name = recipe.name
        self.time = recipe.time
        self.rating = recipe.rating
        self.image = recipe.image
    }
}
