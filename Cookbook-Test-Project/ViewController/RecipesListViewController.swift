//
//  RecipesListViewController.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import UIKit
import PKHUD

protocol DetailFlowProtocol {
    func didTapSwitchToDetail(recipe: Recipe)
}

protocol NewRecipeFlowProtocol {
    func didTapAddNewRecipe()
}

class RecipesListViewController: UITableViewController {

     var detailFlowDelegate: DetailFlowProtocol?
     var newRecipeFlowDelegare: NewRecipeFlowProtocol?
     
    override func loadView() {
        super.loadView()
    }
    
    let viewModel: RecipesListViewModeling
    
    init(viewModel: RecipesListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        //MARK: Todo - not completely done NewRecipeView
        // let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //navigationItem.rightBarButtonItem = addButton
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Recepty"
        tableView.separatorStyle = .none
        
        setupBindings()
        viewModel.loadRecipes()
    }
    
    func setupBindings() {
       _ = viewModel.recipes.asObservable().subscribe(onNext: { [unowned self] recipes in
            self.tableView.reloadData()
        })
        
        _ = viewModel.isRefreshing.asObservable().subscribe(onNext: { [unowned self] value in
            if value {
                HUD.show(HUDContentType.progress)
            } else {
                HUD.hide()
            }
        })
        
        _ = viewModel.detailRecipe.asObservable().subscribe(onNext: { [unowned self] recipe in
            guard let recipe = recipe else { return }
            self.detailFlowDelegate?.didTapSwitchToDetail(recipe: recipe)
        })
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        let recipe = viewModel.recipes.value[indexPath.row]
        cell.setupView(recipe: recipe)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.detailFlowDelegate else { return }
        let recipe = viewModel.recipes.value[indexPath.row]
        viewModel.loadRecipe(withId: recipe.id)
        //delegate.didTapSwitchToDetail()
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        guard let delegate = newRecipeFlowDelegare else { return }
        delegate.didTapAddNewRecipe()
    }

}
