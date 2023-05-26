//
//  HealthStore.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 22/05/23.
//

import Foundation
import HealthKit

//extension Date{
//    static func mondayAt12AM() -> Date{
//        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
//    }
//}

class HealthStore{
    var healthStore :HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init(){
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
        }
    }
    
    func readStepCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: HKUnit.count()))
        
        }
        
        healthStore.execute(query)
        
    }
    
//    func getTodayTotalStepCounts(){
//        guard let sampleType = HKCategoryType.quantityType(forIdentifier: .stepCount)else{
//            return
//        }
//        let startDate = Calendar.current.startOfDay(for: Date())
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
//        var interval = DateComponents()
//        interval.day = 1
//        let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: startDate, intervalComponents: interval)
//        query.initialResultsHandler = {
//            query,result,error in
//            if let myresult = result{
//                myresult.enumerateStatistics(from: startDate, to: Date()) {(statistic, value) in
//                    if let count = statistic.sumQuantity(){
//                        let val = count.doubleValue(for: HKUnit.count())
//                        print("Total step today \(val)")
//                    }
//                }
//            }
//        }
//
//        healthStore?.execute(query)
//    }
    
    
//    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void){
//        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
//
//        let startDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
//
//        let anchorDate = Date.mondayAt12AM()
//
//        let daily = DateComponents(day:1)
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
//
//        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
//        query!.initialResultsHandler = { query, statisticCollection, error in completion(statisticCollection)}
//
//
//        if let healthStore = healthStore, let query = self.query{
//            healthStore.execute(query)
//        }
//
//    }
    
    
    func requestAuthorization(completion: @escaping (Bool) -> Void){
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        guard let healthStore = self.healthStore else {return completion(false)}
        healthStore.requestAuthorization (toShare: [], read: [stepType]) { (success, error) in
            completion (success)}
    }
}
