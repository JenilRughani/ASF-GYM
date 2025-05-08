//
//  WorkoutCategoryViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 23/03/25.
//

import Foundation
import SwiftUI

class WorkoutCategoryViewModel: ObservableObject {
    
    @Published var arrResponseText: [WorkoutCatModel] = []
    @Published var isLoading: Bool = false
    
    func fetchImgCat(type: String) -> WorkoutCat {
        switch type {
        case "ex1":
            return .ex1
        case "ex2":
            return .ex2
        case "ex3":
            return .ex3
        case "ex4":
            return .ex4
        case "ex5":
            return .ex5
        case "ex6":
            return .ex6
        default:
            return .ex4
        }
    }
    
    func callAPI(type: String) {
        
        let types = fetchImgCat(type: type)
        
        let url: String = "https://exercisedb.p.rapidapi.com/exercises/bodyPart/\(types.rawValue)?limit=200&offset=0"
        
        guard let url = URL(string: url) else {
            return debugPrint("URL Missing!!!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("b93010de70mshd60897e2c70e88fp1f6b44jsn4f68ac23e2a5", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("exercisedb.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
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
                
                var secoundyArr: [String] = []
                var instractionArr: [String] = []
                
                data.arrayValue.forEach { gym in
                    
                    gym.dictionaryValue["secondaryMuscles"]?.arrayValue.forEach({ muscules in
                        secoundyArr.append(muscules.stringValue)
                    })
                    
                    gym.dictionaryValue["instructions"]?.arrayValue.forEach({ instra in
                        instractionArr.append(instra.stringValue)
                    })
                    
                    self.arrResponseText.append(WorkoutCatModel(
                        bodyPart: gym.dictionaryValue["bodyPart"]?.stringValue ?? "",
                        equipment: gym.dictionaryValue["equipment"]?.stringValue ?? "",
                        gifUrl: gym.dictionaryValue["gifUrl"]?.stringValue ?? "",
                        name: gym.dictionaryValue["name"]?.stringValue ?? "",
                        target: gym.dictionaryValue["target"]?.stringValue ?? "",
                        secondaryMuscles: secoundyArr.joined(separator: ","),
                        instructions: instractionArr.joined(separator: ","))
                    )
                }
            }
        }
        .resume()
    }
}
