//
//  RecipeDetailViewModel.swift
//  Cookbook
//
//  Created by Adam Sekeres on 17.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import Foundation

protocol RecipeDetailViewModelling {
    var recipe: Recipe { get }
}

class RecipeDetailViewModel: RecipeDetailViewModelling {
    
    var recipe: Recipe
    let apiService : CookbookAPIServicing

    init(recipe: Recipe, apiService: CookbookAPIServicing) {
        self.recipe = recipe
        self.apiService = apiService
    }
}
