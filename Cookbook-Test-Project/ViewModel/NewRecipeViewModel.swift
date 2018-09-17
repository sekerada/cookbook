//
//  NewRecipeViewModel.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import Foundation

protocol NewRecipeViewModelling {
    var recipeName: String { get }
    var nameLabelTitle: String { get }
    var initialTextLabelTitle: String { get }
    var ingredientsLabelTitle: String { get }
    var procedureLabelTitle: String { get }
}

class NewRecipeViewModel: NewRecipeViewModelling {
    
    let nameLabelTitle = "NÁZEV RECEPTU"
    let initialTextLabelTitle = "ÚVODNÍ TEXT"
    let ingredientsLabelTitle = "INGREDIENCE"
    let procedureLabelTitle = "POSTUP"
    
    var recipeName: String = ""
    init() {}
    
}
