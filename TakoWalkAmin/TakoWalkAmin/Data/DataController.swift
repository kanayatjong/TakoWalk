//
//  DataController.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 24/05/23.
//

import Foundation
import CoreData
class DataController: ObservableObject {
let container = NSPersistentContainer (name: "CoreData")
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save (context: NSManagedObjectContext) {
        do {
            try context.save ()
            print ("Data saved!!! WUHU!!!")
        } catch {
            print ("We could not save the data...")
            
        }
    }
    
    func addDaily(date: Date, step: Int, roketKecil: Int, roketBesar: Int) {
        let daily = Daily(context: context)
        daily.date = Date()
        daily.step = Int
        daily.roketKecil = Int
        daily.roketBesar = Int
        save (context: context)
    }
    
    
    
}
