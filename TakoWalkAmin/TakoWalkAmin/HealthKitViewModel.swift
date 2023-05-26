//
//  HealthKitManager.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 22/05/23.
//

import SwiftUI
import HealthKit

class HealthKitViewModel: ObservableObject {
    // Define your properties and methods here
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userStepCount = ""
    @Published var isAuthorized = false
}
