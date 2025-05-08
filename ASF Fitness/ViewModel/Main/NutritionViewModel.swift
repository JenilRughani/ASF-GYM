//
//  NutritionViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import Foundation

class NutritionViewModel: ObservableObject {
    
    @Published var arrResponseText: [NutritionModel] = []
    @Published var isLoading: Bool = false
    @Published var isaddItem: Bool = false
    
    func callListAPI(name: String) {
        let url: String = "https://api.api-ninjas.com/v1/nutrition?query=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
        
        guard let url = URL(string: url) else {
            return debugPrint("URL Missing!!!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("n4hayR/sIMK+ikzMXfdazA==9kCxFL5c4FVMHK8D", forHTTPHeaderField: "X-Api-Key")
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                debugPrint("Error:- Error Can't Caputer: \(String(describing: error?.localizedDescription))")
                self.isLoading = false
                return
            }
            guard let res = response as? HTTPURLResponse else {
                debugPrint("RESPONSE ERROR:- \(String(describing: error?.localizedDescription))")
                self.isLoading = false
                return
            }
            
            guard res.statusCode == StatusCode.Seccuss.rawValue else {
                debugPrint("RESPONSE:- \(res.statusCode)")
                self.isLoading = false
                return
            }
            debugPrint("RESPONSE:- \(res.statusCode)")
            
            guard let jsonData = data else {
                debugPrint("DATA NOT FOUND:- \(String(describing: error?.localizedDescription))")
                self.isLoading = false
                return
            }
            
            let data = JSON(jsonData)
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                data.arrayValue.forEach { nutrition in
                    self.arrResponseText.append(NutritionModel(
                        name: nutrition.dictionaryValue["name"]?.stringValue ?? "",
                        fat: nutrition.dictionaryValue["fat_total_g"]?.stringValue ?? "",
                        fatSaturated: nutrition.dictionaryValue["fat_saturated_g"]?.stringValue ?? "",
                        sodium: nutrition.dictionaryValue["sodium_mg"]?.stringValue ?? "",
                        potassium: nutrition.dictionaryValue["potassium_mg"]?.stringValue ?? "",
                        cholesterol: nutrition.dictionaryValue["cholesterol_mg"]?.stringValue ?? "",
                        carbohydrates: nutrition.dictionaryValue["carbohydrates_total_g"]?.stringValue ?? "",
                        fiber: nutrition.dictionaryValue["fiber_g"]?.stringValue ?? "",
                        sugar: nutrition.dictionaryValue["sugar_g"]?.stringValue ?? "")
                    )
                }
                
                self.isaddItem = true
            }
        }
        .resume()
    }
}
