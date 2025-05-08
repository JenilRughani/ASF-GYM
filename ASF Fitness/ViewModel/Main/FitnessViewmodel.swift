//
//  FitnessViewmodel.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import Foundation

class FitnessViewModel: ObservableObject {
    
    @Published var arrResponseText: [FitnessGideModel] = []
    @Published var isLoading: Bool = false
    
    func callAPI() {
        let url: String = "https://api.api-ninjas.com/v1/exercises"
        
        guard let url = URL(string: url) else {
            return debugPrint("URL Missing!!!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
                
                data.arrayValue.forEach { jsondata in
                    self.arrResponseText.append(FitnessGideModel(name: jsondata.dictionaryValue["name"]?.stringValue ?? "", type: jsondata.dictionaryValue["type"]?.stringValue ?? "", muscle: jsondata.dictionaryValue["muscle"]?.stringValue ?? "", equipment: jsondata.dictionaryValue["equipment"]?.stringValue ?? "", difficulty: jsondata.dictionaryValue["difficulty"]?.stringValue ?? "", instructions: jsondata.dictionaryValue["instructions"]?.stringValue ?? ""))
                }
            }
        }
        .resume()
    }
}
