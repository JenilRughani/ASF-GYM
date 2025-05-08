//
//  HealthViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import Foundation
import HealthKit
import SwiftUI

class HealthViewModel: ObservableObject {
    
    @Published var healthData: [HealthModel] = []
    
    private let healthStore = HKHealthStore()
    private let key = "HealthData"
    
    init() {
        loadData()
        requestHealthAuthorization()
    }
    
    // ✅ Request HealthKit Authorization
    func requestHealthAuthorization() {
        let typesToShare: Set = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]
        
        let typesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            if !success {
                print("Authorization failed: \(String(describing: error))")
            }
        }
    }
    
    // ✅ Save Data to UserDefaults
    func saveData() {
        if let encoded = try? JSONEncoder().encode(healthData) {
            UserDefaults.standard.set(encoded, forKey: key)
            print("Saved in Local Database")
        }
    }
    
    // ✅ Load Data from UserDefaults
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decodedData = try? JSONDecoder().decode([HealthModel].self, from: savedData) {
            healthData = decodedData
        }
    }
    
    // ✅ Add New Health Data (Local + HealthKit)
    func addHealthData(steps: String, heartRate: String, training: String, calories: String, sleep: String, distance: String) {
        let newData = HealthModel(
            steps: steps,
            heartRate: heartRate,
            training: training,
            calories: calories,
            sleep: sleep,
            distance: distance,
            dateTime: Date()
        )
        
        healthData.append(newData)
        saveData()
        
        // Save to Apple Health
        saveToHealthKit(steps: steps, heartRate: heartRate, calories: calories, sleep: sleep, distance: distance)
    }
    
    // ✅ Save to Apple Health
    func saveToHealthKit(steps: String, heartRate: String, calories: String, sleep: String, distance: String) {
        let now = Date()
        
        // Steps
        if let stepsCount = Double(steps),
           let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount) {
            let quantity = HKQuantity(unit: .count(), doubleValue: stepsCount)
            let sample = HKQuantitySample(type: stepsType, quantity: quantity, start: now, end: now)
            
            healthStore.save(sample) { success, error in
                if success {
                    print("Steps saved to HealthKit")
                } else {
                    print("Error saving steps: \(String(describing: error))")
                }
            }
        }
        
        // Heart Rate
        if let heartRateCount = Double(heartRate),
           let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) {
            let quantity = HKQuantity(unit: HKUnit(from: "count/min"), doubleValue: heartRateCount)
            let sample = HKQuantitySample(type: heartRateType, quantity: quantity, start: now, end: now)
            
            healthStore.save(sample) { success, error in
                if success {
                    print("Heart Rate saved to HealthKit")
                } else {
                    print("Error saving heart rate: \(String(describing: error))")
                }
            }
        }
        
        // Calories
        if let caloriesBurned = Double(calories),
           let caloriesType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) {
            let quantity = HKQuantity(unit: .kilocalorie(), doubleValue: caloriesBurned)
            let sample = HKQuantitySample(type: caloriesType, quantity: quantity, start: now, end: now)
            
            healthStore.save(sample) { success, error in
                if success {
                    print("Calories saved to HealthKit")
                } else {
                    print("Error saving calories: \(String(describing: error))")
                }
            }
        }
        
        // Distance
        if let distanceVal = Double(distance),
           let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) {
            let quantity = HKQuantity(unit: .meter(), doubleValue: distanceVal)
            let sample = HKQuantitySample(type: distanceType, quantity: quantity, start: now, end: now)
            
            healthStore.save(sample) { success, error in
                if success {
                    print("Distance saved to HealthKit")
                } else {
                    print("Error saving distance: \(String(describing: error))")
                }
            }
        }
    }
    
    // ✅ Delete Health Data
    func deleteHealthData(at offsets: IndexSet) {
        DispatchQueue.main.async {
            withAnimation {
                self.healthData.remove(atOffsets: offsets)
            }
            
            self.saveData()
        }
    }
    
    // ✅ Get Latest Health Data
    func latestHealthData() -> HealthModel? {
        return healthData.last
    }
}
