//
//  RecipeViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 25/03/25.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    
    @Published var arrResponseText: [RecipeModel] = []
    @Published var isLoading: Bool = false
    
    func callListAPI(ids: String) {
        
        let url: String = "https://api.spoonacular.com/recipes/informationBulk?ids=\(ids)"
        print("Food API Call: \(url)")
        guard let url = URL(string: url) else {
            return debugPrint("URL Missing!!!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("179f66313d3242be89060eb25f1f38fc", forHTTPHeaderField: "x-api-key")
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                debugPrint("Error:- \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            guard let res = response as? HTTPURLResponse else {
                debugPrint("RESPONSE ERROR:- \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            guard res.statusCode == 200 else {
                debugPrint("RESPONSE:- \(res.statusCode)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            guard let jsonData = data else {
                debugPrint("DATA NOT FOUND:- \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            let json = JSON(jsonData)
            
            DispatchQueue.global(qos: .background).async {
                var arrRecipes: [RecipeModel] = []
                
                json.arrayValue.forEach { recipe in
                    var arrDishType: [String] = []
                    
                    recipe.dictionaryValue["dishTypes"]?.arrayValue.forEach { dish in
                        arrDishType.append(dish.stringValue)
                    }
                    
                    let newRecipe = RecipeModel(
                        image: recipe.dictionaryValue["image"]?.stringValue ?? "",
                        title: recipe.dictionaryValue["title"]?.stringValue ?? "",
                        sourceUrl: recipe.dictionaryValue["sourceUrl"]?.stringValue ?? "",
                        vegetarian: recipe.dictionaryValue["vegetarian"]?.boolValue ?? false,
                        dishTypes: arrDishType.joined(separator: ",\n"),
                        healthScore: recipe.dictionaryValue["healthScore"]?.stringValue ?? "",
                        instructions: recipe.dictionaryValue["instructions"]?.stringValue ?? "",
                        summery: recipe.dictionaryValue["summary"]?.stringValue ?? ""
                    )
                    
                    arrRecipes.append(newRecipe)
                }
                
                DispatchQueue.main.async {
                    self.arrResponseText = arrRecipes
                    self.isLoading = false
                }
            }
        }
        .resume()
    }
}
