//
//  HealthFitnessViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import Foundation
import SwiftUI

class HealthFitnessViewModel: ObservableObject {
    @Published var arrResponseText: [HealthFitnessModel] = []
    @Published var isLoading: Bool = false
    
    func callAPI() {
        let url: String = "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=2ffe15c95b2946b58a7e42e5a10385ea"
        
        guard let url = URL(string: url) else {
            return debugPrint("URL Missing!!!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
                
                data.dictionaryValue["articles"]?.arrayValue.forEach({ healthTips in
                    self.arrResponseText.append(HealthFitnessModel(title: healthTips.dictionaryValue["title"]?.stringValue ?? "", author: healthTips.dictionaryValue["author"]?.stringValue ?? "", urlToImage: healthTips.dictionaryValue["urlToImage"]?.stringValue ?? "", url: healthTips.dictionaryValue["url"]?.stringValue ?? "", description: healthTips.dictionaryValue["description"]?.stringValue ?? "", content: healthTips.dictionaryValue["content"]?.stringValue ?? "", publishedAt: healthTips.dictionaryValue["publishedAt"]?.stringValue ?? ""))
                })
            }
        }
        .resume()
    }
}
