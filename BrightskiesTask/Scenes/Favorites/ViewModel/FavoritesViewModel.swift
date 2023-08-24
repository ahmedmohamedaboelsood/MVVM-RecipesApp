//
//  FavoritesViewModel.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 24/08/2023.
//

import Foundation
import CoreData

protocol FavoraitsViewModelDelegate{
    func deletionDone(message:String)
    func deletionFail(message:String)
}

class FavoraitsViewModel {
    var isLoading : Observable<Bool> = Observable(false)
    var delegate : FavoraitsViewModelDelegate?
    var numberOfItems : Int?
    var recipesArray: [RecipesCoreDataModel] = []
    func numberOfsections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int)->Int{
        numberOfItems ?? 0
    }
    
    func fetchData(){
        isLoading.value = true
        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        do {
            let fetchedRecipes = try context.fetch(fetchRequest)
            
            if fetchedRecipes.isEmpty {
                print("No data")
                isLoading.value = false
            } else {
                for recipe in fetchedRecipes {
                    if let id = recipe.id , let name = recipe.name , let image = recipe.image, let rate = recipe.rating as? Double, let time = recipe.time   {
                        let recipeObject = RecipesCoreDataModel(id: id, fats: "", time: time, name: name, image: image, carbos: "", rating: rate, fibers: "", country: "", ratings: 0, calories: "", headline: "", proteins: "", favorites: 0, difficulty: 0, recipedescription: "", highlighted: true)
                        recipesArray.append(recipeObject)
                    }else{
                        print("Can't parse nil object")
                    }
                    numberOfItems = recipesArray.count
                    isLoading.value = false
                }
            }
        } catch {
            print("Error fetching products: \(error)")
        }
    }
    
    func removeDuplication(){
        recipesArray = []
    }
    
    func deleteFromCoreData(indexPath:IndexPath){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recipes")
        do{
            let myProduct = try context.fetch(fetchRequest)
            context.delete(myProduct[indexPath.row])
            try context.save()
            recipesArray.remove(at: indexPath.row)
            numberOfItems = numberOfItems! - 1
            delegate?.deletionDone(message: "Deleted Succefully")
        }catch{
            print(error)
            delegate?.deletionFail(message: "Something went wrong")
        }
    }
}
