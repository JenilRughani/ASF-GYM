//
//  AIChatViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import Foundation
import SwiftUI

@MainActor
class AIChatViewModel: ObservableObject {
    
    @Published var responseText: String = ""
    @Published var isLoading: Bool = false
    
    func fetchGeminiResponse(query: String) async {
        isLoading = true
        
        guard let url = URL(string: APIHandler.geminiAPILink) else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = APIMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": query]
                    ]
                ]
            ]
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed response: \(response)")
                isLoading = false
                return
            }
            
            let dataJSON = JSON(data)
            
            DispatchQueue.main.async {
                self.responseText = dataJSON.dictionaryValue["candidates"]?.arrayValue.first?.dictionaryValue["content"]?.dictionaryValue["parts"]?.arrayValue.first?.dictionaryValue["text"]?.stringValue ?? "No response received"
                
                print("Gemini Response: \(self.responseText)")
            }
            
        } catch {
            print("API Error: \(error.localizedDescription)")
            responseText = "Failed to fetch data"
        }
        
        isLoading = false
    }
}
