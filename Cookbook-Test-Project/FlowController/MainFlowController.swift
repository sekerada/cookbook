//
//  MainFlowController.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import Foundation
import UIKit

class MainFlowController {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cookbookAPIService = CookbookAPIService(network: Network())
        let recipesViewModel = RecipesListViewModel(apiService: cookbookAPIService)
        let recipesListViewController = RecipesListViewController(viewModel: recipesViewModel)
        recipesListViewController.detailFlowDelegate = self
        recipesListViewController.newRecipeFlowDelegare = self
        self.navigationController.viewControllers = [recipesListViewController]
    }
}

extension MainFlowController: NewRecipeFlowProtocol {
    func didTapAddNewRecipe() {
        let newRecipeViewModel = NewRecipeViewModel()
        let newRecipeViewController = NewRecipeViewController(viewModel: newRecipeViewModel)
        self.navigationController.topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Zpět", style: .plain, target: nil, action: nil)
        self.navigationController.pushViewController(newRecipeViewController, animated: true)
    }
}

extension MainFlowController: DetailFlowProtocol {
    func didTapSwitchToDetail(recipe: Recipe) {
        let recipeDetailViewModel = RecipeDetailViewModel(recipe: recipe, apiService: CookbookAPIService(network: Network()))
        let recipeDetailViewController = RecipeDetailViewController(viewModel: recipeDetailViewModel)
        recipeDetailViewController.navigationItem.backBarButtonItem?.title = "Zpet"
        self.navigationController.topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Zpět", style: .plain, target: nil, action: nil)
        self.navigationController.pushViewController(recipeDetailViewController, animated: true)
    }
}
