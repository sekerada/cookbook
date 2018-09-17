//
//  CookbookAPIService.swift
//  Cookbook-Test-Project
//
//  Created by Dominik Vesely on 12/01/2017.
//  Copyright © 2017 Dominik Vesely. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

protocol CookbookAPIServicing {
    //func getRecipes() -> SignalProducer<[Recipe],RequestError>
    func getRecipes() -> Observable<[Recipe]>
    func getRecipe(withId id: String) -> Observable<Recipe?>
}

/// Concrete class for creating api calls to our server
class CookbookAPIService : APIService, CookbookAPIServicing {
    
    
    private static let baseURL = URL(string: "https://cookbook.ack.ee/api/v1/")!
    
    override func resourceURL(for path: String) -> URL {
        return CookbookAPIService.baseURL.appendingPathComponent(path)
    }

    func getRecipes() -> Observable<[Recipe]> {
        return Observable.create({ [unowned self] observer in
            self.request("recipes").subscribe(onNext: {  data, error in
                guard let data = data else {
                    observer.onError(error!)
                    observer.onCompleted()
                    return
                }
                var recipes = [Recipe]()
                guard let jsonRecipesArray = JSON(data).array else {
                    observer.onNext(recipes)
                    return
                }
                for jsonRecipe in jsonRecipesArray {
                    guard let recipe = Recipe(jsonData: jsonRecipe) else { continue }
                    recipes.append(recipe)
                }
                observer.onNext(recipes)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    func getRecipe(withId id: String) -> Observable<Recipe?> {
        return Observable.create({ [unowned self] observer in
           _ = self.request("recipes/\(id)").subscribe(onNext: { data, error in
                if error == nil {
                    guard let data = data, let recipe = Recipe(jsonData: JSON(data)) else { observer.onNext(nil);  return }
                    observer.onNext(recipe)
                    observer.onCompleted()
                } else {
                    observer.onError(error!)
                }
            }, onError: { error in
                    observer.onError(error)
            })
            return Disposables.create()
        })
    }
}
