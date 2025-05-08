//
//  YogaViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 03/04/25.
//

import Foundation

class YogaViewModel: ObservableObject {
    @Published var arrResponseText: [YogaModel] = []
    @Published var isLoading: Bool = false
    
    func callAPI() {
        let url: String = "https://yoga-api-nzy4.onrender.com/v1/categories"
        
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
                
                data.arrayValue.forEach({ catYoga in
                    catYoga.dictionaryValue["poses"]?.arrayValue.forEach({ yoga in
                        self.arrResponseText.append(YogaModel(
                            img: yoga.dictionary?["url_png"]?.stringValue ?? "",
                            catName: yoga.dictionary?["category_name"]?.stringValue ?? "",
                            englishName: yoga.dictionary?["english_name"]?.stringValue ?? "",
                            pose_description: yoga.dictionary?["pose_description"]?.stringValue ?? "",
                            pose_benefits: yoga.dictionary?["pose_benefits"]?.stringValue ?? "")
                        )
                    })
                })
            }
        }
        .resume()
    }
}
