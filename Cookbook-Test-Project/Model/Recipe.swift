//
//  Recipe.swift
//  Cookbook
//
//  Created by Adam Sekeres on 16.9.18.
//  Copyright © 2018 Dominik Vesely. All rights reserved.
//

import Foundation
import SwiftyJSON

class Recipe {
    
//    "name": "Ackee and Saltfish",
//    "description": "Cover the saltfish in cold water. Let soak overnight (minimum 8 hours) changing the water several times (this removes most of the salt)\n    Bring a pan of cold water to the boil and gently simmer the fish for 20 minutes (until the fish is tender).\n    Chop the onion, sweet pepper, chilli pepper and tomato.\n    Remove the fish from water and allow to cool.\n    Remove all of bones and skin then flake the flesh of the fish.  \n    Melt the butter in a frying pan and stir fry the onion, black pepper, sweet pepper, chilli and thyme for about 3 minutes. \n    Add the tomatoes and flaked fish and stir-fry for another 10 minutes\n    Add the Ackee and cook until hot throughout. Stir gently to avoid breaking-up the Ackee\n    Serve with yam, green banana, fried dumplings and Irish potato\n    ",
//    "duration": 10,
//    "ingredients": [
//    "1/2 lb Saltfish (dried, salted codfish)",
//    "12 fresh ackees or 1 (drained) can of tinned ackees",
//    " 1 medium onion",
//    "1/2 tsp black pepper",
//    "3 tbsp of butter",
//    "1/2 a hot chilli pepper (ideally Scotch Bonnet)",
//    "1 sweet pepper",
//    "1 chopped tomato",
//    "1 sprig fresh thyme or 1 tsp dried thyme",
//    "2 cloves of garlic",
//    "4 Scallion (or spring onions)",
//    "6 Slices of bacon"
//    ],
//    "info": "Simple but fast and furious",
//    "id": "58777f22b23541fc058c789f",
//    "score": 0
//    
//    
//    {
//    "name": "Ackee and Saltfish",
//    "duration": 10,
//    "id": "58777f22b23541fc058c789f",
//    "score": 0
//    }
//    
    
    
    
    let info: String
    let ingredients: [String]
    let description: String
  
    let name: String
    let id: String
    let score: Int
    let duration: Int
    
    init(name: String, id: String, score: Int, duration: Int, info: String = "", description: String = "", ingredients: [String] = [String]()) {
        self.name = name
        self.id = id
        self.score = score
        self.duration = duration
        self.info = info
        self.description = description
        self.ingredients = ingredients
    }
    
    convenience init?(jsonData: JSON) {
        guard let name = jsonData["name"].string,
        let id = jsonData["id"].string, let score = jsonData["score"].int, let duration = jsonData["duration"].int else { return nil }
        
        guard let ingredients = jsonData["ingredients"].arrayObject as? [String],
            let description = jsonData["description"].string, let info = jsonData["info"].string else {
              self.init(name: name, id: id, score: score, duration: duration)
              return
        }
        
        self.init(name: name, id: id, score: score, duration: duration, info: info, description: description, ingredients: ingredients)
    }
    
//    convenience init() {
//        
//    }
}
