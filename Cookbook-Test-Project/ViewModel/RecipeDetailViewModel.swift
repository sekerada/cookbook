//
//  RecipeDetailViewModel.swift
//  Cookbook
//
//  Created by Adam Sekeres on 17.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import Foundation
import RxSwift

protocol RecipeDetailViewModelling {
    var recipe: Variable<Recipe> { get }
}

class RecipeDetailViewModel: RecipeDetailViewModelling {
    
    var recipe: Variable<Recipe>
    let apiService : CookbookAPIServicing

    init(recipe: Recipe, apiService: CookbookAPIServicing) {
        self.recipe = Variable<Recipe>(recipe)
        self.apiService = apiService
    }
}
