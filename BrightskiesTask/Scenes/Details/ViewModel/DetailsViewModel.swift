//
//  DetailsViewModel.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 23/08/2023.
//

import Foundation

class DetailsViewModel{
    
    //MARK: - Variables
    var recipe : HomeDataModel
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
    
    init(recipe: HomeDataModel) {
        self.recipe = recipe
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
}
