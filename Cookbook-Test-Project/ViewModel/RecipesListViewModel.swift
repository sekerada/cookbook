//
//  RecipesListViewModel.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import Foundation
import RxSwift
 
protocol RecipesListViewModeling {
    var recipes : Variable<[Recipe]> {get}
    func loadRecipes()
    func loadRecipe(withId id: String)
    var isRefreshing: Variable<Bool> { get }
    var detailRecipe: Variable<Recipe?> { get }
}

class RecipesListViewModel: RecipesListViewModeling {
    let dBag = DisposeBag()
    let apiService : CookbookAPIServicing
    let recipes = Variable<[Recipe]>([])
    let isRefreshing = Variable<Bool>(false)
    let detailRecipe = Variable<Recipe?>(nil)
    
    init(apiService: CookbookAPIServicing) {
       self.apiService = apiService
    }
    
    func loadRecipes() {
        apiService.getRecipes().subscribe(onNext: { recipes in
            self.recipes.value = recipes
        }, onError: { error in
            print("Error: load recipes")
        }).disposed(by: dBag)
    }
    
    func loadRecipe(withId id: String) {
        self.isRefreshing.value = true
       _ = apiService.getRecipe(withId: id).subscribe(onNext: { [unowned self] recipe in
            self.isRefreshing.value = false
            guard let recipe = recipe else { self.detailRecipe.value = nil; return }
            self.detailRecipe.value = recipe
        }, onError: { [unowned self] error in
            self.isRefreshing.value = false
            self.detailRecipe.value = nil
        })
    }
    
}
