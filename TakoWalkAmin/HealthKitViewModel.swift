//
//  HealthKitViewModel.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 23/05/23.
//

import Foundation
import HealthKit
import CoreData
import SwiftUI

class HealthKitViewModel: ObservableObject {
    
    @Published var userStepCount = "0"
    @Published var isAuthorized = false
    @Published var timer: Timer?
    @Published var progressBar: Double = 0
    @Published var rocketPositionY: Double = 286
    
    @Published var score: Int64 = 0
    @Published var coin: Int64 = 0
    @Published var jumlahRoketBesar: Int64 = 0
    @Published var jumlahRoketKecil: Int64 = 0
    @Published var progressLangkah: Int = 0
    @Published var rotationAngle: Angle = .degrees(0)
    
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    var targetReached: Bool = false
    var roketKe: Int = 1
    var roketPetama: Bool = true
    var historyRoket: [Int] = []
    var roketImg: String = ""
    var pertamaKaliBukaApp: Bool = false
    var sisaStepSaatIni: Int = 0
    var ambilBrpDariArray: Int = 0
    var roketTerbang: Bool = false
    var turun: Bool = false
    var currentTotal: Total?
    
    init(){
        currentTotal = CoreDataManager.shared.getLatestTotal()
    }
    
//
//    @FetchRequest (sortDescriptors: [SortDescriptor (\.date, order: .reverse) ]) var Daily:
//    FetchedResults<Daily>
//    @FetchRequest var Total:FetchedResults<Total>
    
    func getDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"

        let date = Date()
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    
    func startReadingSteps() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [self] state in
            readStepsTakenToday()
        }
    }
    
    
    func getRocket()->String{
//        let randomInt = Int.random(in: 1...2)
//        if randomInt == 1{
            return "ROKET BESAR"
//        }else{
//            return "ROKET KECIL"
//        }
    }
    
    func getRemainingSteps(steps: Int, target: Int) -> Double {
        if steps < target {
            return Double(steps)
        }
        
        return getRemainingSteps(steps: steps - target, target: target)
    }
    
    func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            // 1. Menambahkan step yang didapat dengan step yang sebelumnya yang didapat core data
            // 2. Validasi logic untuk jenis roket dan koin
            // 3. Save lagi ke core untuk data step yang terbaru
            
            DispatchQueue.main.async { [self] in
                self.userStepCount = String(format: "%.0f", step)
                let stepCount = Int(self.userStepCount)
                var temp = 0.0
                if roketImg == "ROKET BESAR" {
                    temp = Double(getRemainingSteps(steps: Int(userStepCount)!, target: 1500))
                    progressBar = (temp / 1500.0) * 140.0
                }else{
                    temp = getRemainingSteps(steps: Int(userStepCount)!, target: 500)
                    progressBar = (temp / 500.0) * 140.0
                }
          
                print("progress: \(progressBar)")
                print("\(self.userStepCount)")
                
                if roketImg == "ROKET BESAR" && roketKe == 1 && Int(userStepCount)! < 1000{
                    progressLangkah = 1000 - Int(userStepCount)!
                    
                    if(progressLangkah <= 0){
                        progressLangkah = 1000
                    }else{
                        progressLangkah = Int(userStepCount)!
                    }
                    
                }else if roketImg == "ROKET BESAR" && roketKe == 1 && Int(userStepCount)! >= 1000{
                    progressLangkah = 1000 - Int(userStepCount)!
                    
                    if(progressLangkah <= 0){
                        progressLangkah = 1000
                    }else{
                        progressLangkah = Int(userStepCount)!
                    }
                    
                    self.historyRoket.append(1000)
                    self.roketKe = self.roketKe + 1
                    self.pertamaKaliBukaApp = true
                    print("Roket terbang 1")
                    jumlahRoketBesar = jumlahRoketBesar + 1
                    
                    self.rocketPositionY = -278
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
//                        roketImg = getRocket()
//                        if roketImg == "ROKET BESAR"{
                            rocketPositionY = 266
                        print("pos \(rocketPositionY)")
//                            print("turun")
//                        }else{
//                            rocketPositionY = 286
//                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
                        print("waiting")
                    
                    }
                    coin = coin + 10
                    
                }else if roketImg == "ROKET KECIL" && roketKe == 1 && Int(userStepCount)! >= 500{
                    self.historyRoket.append(500)
                    self.roketKe = self.roketKe + 1
                    self.pertamaKaliBukaApp = true
                    print("Roket terbang 2")
                    coin = coin + 5
                    jumlahRoketKecil = jumlahRoketKecil + 1
                    
//                    naik
//                    self.positionY = -286
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
                        roketImg = getRocket()
                        if roketImg == "ROKET BESAR"{
                            rocketPositionY = 266
                        }else{
                            rocketPositionY = 286
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
                        print("waiting")
                    }
                    
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [self] in
//                        self.positionY = 286
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) { [self] in
//                        roket = getRocket()
//                        if roket == "ROKET BESAR"{
//                            positionY = 266
//                        }else{
//                            positionY = 286
//                        }
//                    }
                    
                }else if roketImg == "ROKET BESAR" && roketKe != 1{
                    ambilBrpDariArray = self.roketKe - 1
                 
                    var stepsTotal = 0
                    for i in 0 ..< ambilBrpDariArray {
                        stepsTotal += historyRoket[i]
                    }
                    
                    sisaStepSaatIni = stepCount! - stepsTotal
             
                    progressLangkah = 1000 - sisaStepSaatIni
                    
                    if progressLangkah <= 0{
                        progressLangkah = 1000
                    }else {
                        progressLangkah = sisaStepSaatIni
                    }
                    
                    if sisaStepSaatIni >= 1000{
                        self.historyRoket.append(1000)
                        self.roketKe = self.roketKe + 1
                        print("Roket terbang 3")
                        
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            self.rocketPositionY = -278
//                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
                            roketImg = getRocket()
                            if roketImg == "ROKET BESAR"{
                                rocketPositionY = 266
                                print("turun")
                            }else{
                                rocketPositionY = 286
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
                            print("waiting")
                        
                        }
                        
                        coin = coin + 10
                        jumlahRoketBesar = jumlahRoketBesar + 1
                    }
                    
                }else if roketImg == "ROKET KECIL" && roketKe != 1{
                    ambilBrpDariArray = self.roketKe - 1
                 
                    var stepsTotal = 0
                    for i in 0 ..< ambilBrpDariArray {
                        stepsTotal += historyRoket[i]
                    }
                    
                    sisaStepSaatIni = stepCount! - stepsTotal
                    
                    if sisaStepSaatIni >= 500{
                        self.historyRoket.append(500)
                        self.roketKe = self.roketKe + 1
                        print("Roket terbang 4")
                        
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [self] in
//                        withAnimation(.linear(duration: 3)) {
                            rocketPositionY = -286
//                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
//                        withAnimation(.linear(duration: 3)) {
                            roketImg = getRocket()
                            if roketImg == "ROKET BESAR"{
                                rocketPositionY = 266
                            }else{
                                rocketPositionY = 286
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 9) { [self] in
                            print("waiting")
                        }
                        
                        coin = coin + 5
                        jumlahRoketKecil = jumlahRoketKecil + 1
                    }
                    
                }
            }
            // Update core data
//            CoreDataManager.shared.addTotal(score:Int64(self.userStepCount)!, koin: Int64(self.coin))
//            self.score = self.currentTotal!.score
//            print("total: \(self.currentTotal?.score)")
        }
    }
    
    func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        
        switch status {
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            isAuthorized = true
        @unknown default:
            isAuthorized = false
        }
    }
    
}
