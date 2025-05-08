//
//  NotificationManagerViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 31/03/25.
//

import Foundation
import SwiftUI
import UserNotifications
import FirebaseFirestore
import Combine

// MARK: - Notification Manager
class NotificationManagerViewModel: ObservableObject {
    
    @Published var notifications: [NotificationModel] = []
    @Published var isAlert: Bool = false
    @Published var isLoadView: Bool = false
    @Published var alertMessage: String = ""
    
    private var firestore = FirebaseManager()
    
    func requestAuthNotify(compliation: @escaping (Result<String, Error>) -> Void) {
        let opttion: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: opttion) { scuccess, error in
            if let error = error {
                print(error.localizedDescription)
                compliation(.failure(error))
            } else {
                print("Successfully Added Notifiy!")
                compliation(.success("Successfully Added Notifiy!"))
            }
        }
    }
    
    func notifySchedule(email: String, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        
        let data: [String: Any] = [
            "title" : title,
            "body" : body
        ]
        
        Firestore.firestore().collection(email).document(FirebaseMainCollection.userFunDetails.rawValue).collection("Notify").document(getCurrentDate()).setData(data) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
               print("Saved Notification Successfully in Firebase!")
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        
        let request =  UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Sccessfully Added the Notification!")
            }
        }
    }
    
    func getNotifyAllData(email: String) {
        DispatchQueue.main.async {
            self.isLoadView = true
        }
        
        let notifyRef = Firestore.firestore().collection(email).document(FirebaseMainCollection.userFunDetails.rawValue).collection("Notify")
        
        notifyRef.getDocuments { sanp, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let sanps = sanp {
                DispatchQueue.main.async {
                    self.notifications = sanps.documents.compactMap { doc -> NotificationModel? in
                        let dateString = doc.documentID
                        let date = dateString
                        
                        let data = doc.data()
                        let title = data["title"] as? String ?? "No Title"
                        let body = data["body"] as? String ?? "No Description"
                        
                        return NotificationModel(id: doc.documentID, title: title, body: body, date: date)
                    }
                    self.notifications.sort { $0.date > $1.date } // Sort by latest first
                    
                    self.isLoadView = false
                }
            }
        }
        
//        Firestore.firestore().collection(email).document(FirebaseMainCollection.userFunDetails.rawValue).collection("Notify").document(getCurrentDate()).getDocument { snapshot, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = snapshot?.data() else {
//                completion(.success([]))
//                return
//            }
//            
//            let document = FirebaseDataModel(id: snapshot?.documentID ?? UUID().uuidString, data: data)
//            completion(.success([document]))
//        }
    }
}
