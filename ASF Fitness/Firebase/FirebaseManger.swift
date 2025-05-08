//
//  FirebaseManger.swift
//  ASF
//
//  Created by Jenil Rughani on 30/03/25.
//

import FirebaseFirestore
import Combine

class FirebaseManager: ObservableObject {
    private var db = Firestore.firestore()
    
    // ✅ Create or Update Dynamic Data
    func saveData(email: String, collection: FirebaseMainCollection, documentId: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(email).document(collection.rawValue).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // ✅ Read Dynamic Data
    func fetchData(email: String, collection: FirebaseMainCollection, completion: @escaping (Result<[FirebaseDataModel], Error>) -> Void) {
        db.collection(email).document(collection.rawValue).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = snapshot?.data() else {
                completion(.success([]))
                return
            }
            
            let document = FirebaseDataModel(id: snapshot?.documentID ?? UUID().uuidString, data: data)
            completion(.success([document]))
        }
    }
    
    // ✅ Update Dynamic Data
    func updateData(email: String, collection: FirebaseMainCollection, documentId: String, newData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(email).document(collection.rawValue).updateData(newData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // ✅ Delete Dynamic Data
    func deleteData(email: String, collection: FirebaseMainCollection, documentId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(email).document(collection.rawValue).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
