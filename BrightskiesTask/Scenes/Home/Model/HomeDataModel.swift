//
//  HomeDataModel.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 21/08/2023.
//

import Foundation
// MARK: - HomeDataModel

struct HomeDataModel: Decodable {
    let id, fats, name, time: String
    let image: String
    let weeks: [String]
    let carbos, fibers: String
    let rating: Double?
    let country: String
    let ratings: Int?
    let calories, headline: String
    let keywords, products: [String]
    let proteins: String
    let favorites, difficulty: Int
    let description: String
    let highlighted: Bool
    let ingredients: [String]
    let deliverableIngredients: [String]
}

typealias HomeData = [HomeDataModel]
