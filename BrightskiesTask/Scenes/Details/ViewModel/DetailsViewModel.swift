//
//  DetailsViewModel.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 23/08/2023.
//

import Foundation
import CoreData

protocol DetailsViewModelDelegate{
    func cashingRecipeIsDone(message:String)
    func cashingRecipeIsFail(message:String)
}

class DetailsViewModel{
    
    //MARK: - Variables
    var recipe : HomeDataModel
    var recipeId : String
    var recipeImage : String
    var recipeName : String
    var recipeDescription : String
    var recipeHeadline : String
    var recipeTime : String
    var recipeCalories : String
    var recipeRating : Double?
    var recipeFats : String
    var recipeCarbs : String
    var recipeProtien : String
    var recipeIngrediants : [String]
    var delegate : DetailsViewModelDelegate?
    var favDelegate : FavoraitsViewModelDelegate?
    var favArray : [RecipesCoreDataModel] = []
    
    init(recipe: HomeDataModel) {
        self.recipe = recipe
        self.recipeId = recipe.id
        self.recipeImage = recipe.image
        self.recipeName = recipe.name
        self.recipeHeadline = recipe.headline
        self.recipeTime = "\(extractNumbersManuallyFromString(recipe.time).first ?? 0)"
        self.recipeRating = recipe.rating
        self.recipeCalories = recipe.calories
        self.recipeCarbs = recipe.carbos
        self.recipeFats = recipe.fats
        self.recipeProtien = recipe.proteins
        self.recipeDescription = recipe.description
        self.recipeIngrediants = recipe.ingredients
    }
    
    func addProductToCoreData(){
         let entity = NSEntityDescription.insertNewObject(forEntityName: "Recipes", into: context) as? Recipes
        entity?.id = recipe.id
        entity?.calories = recipe.calories
        entity?.fats = recipe.fats
        entity?.proteins = recipe.proteins
        entity?.carbos = recipe.carbos
        entity?.image = recipe.image
        entity?.name = recipe.name
        entity?.headline = recipe.headline
        entity?.time = recipe.time
        entity?.rating = recipe.rating ?? 0
        entity?.recipedescription = recipe.description
        entity?.ingredients = recipe.ingredients as NSObject
        do{
            try context.save()
            delegate?.cashingRecipeIsDone(message: "Added Successfully")
        }catch{
            delegate?.cashingRecipeIsFail(message: "Something went wrong")
        }
    }
    
    func fetchData(recipeId:String)->Bool{
        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        do {
            let fetchedRecipes = try context.fetch(fetchRequest)
            
            if fetchedRecipes.isEmpty {
                print("No data")
            } else {
                for recipe in fetchedRecipes {
                    if let id = recipe.id , let name = recipe.name , let image = recipe.image, let rate = recipe.rating as? Double, let time = recipe.time   {
                        let recipeObject = RecipesCoreDataModel(id: id, fats: "", time: time, name: name, image: image, carbos: "", rating: rate, fibers: "", country: "", ratings: 0, calories: "", headline: "", proteins: "", favorites: 0, difficulty: 0, recipedescription: "", highlighted: true)
                        favArray.append(recipeObject)
                    }else{
                        print("Can't parse nil object")
                    }
                }
            }
        } catch {
            print("Error fetching products: \(error)")
        }
        if favArray.contains(where: {$0.id == recipeId}){
            return true
        }else{
            return false
        }
    }
    
    func deleteObjectByID(objectID: String) {
        
        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", objectID)
        
        do {
            if let objectsToDelete = try context.fetch(fetchRequest) as? [Recipes], let objectToDelete = objectsToDelete.first {
                context.delete(objectToDelete)
                try context.save()
                favDelegate?.deletionDone(message: "Removed from favoraits successfully")
            } else {
                print("Object with ID \(objectID) not found")
            }
        } catch {
            favDelegate?.deletionFail(message: "Error deleting object") 
        }
    } 
}
