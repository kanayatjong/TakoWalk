//
//   CoreDataManager.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 24/05/23.
//



import Foundation
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "TakoWalkAmin")
    let context: NSManagedObjectContext
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
        context = container.viewContext // Initialize the context property
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addDaily(step: String, date: Date, roketKecil: Int16, roketBesar: Int16) {
        let daily = Daily(context: context)
        daily.step = step
        daily.date = date 
        daily.roketKecil = roketKecil
        daily.roketBesar = roketBesar
        save(context: context)
    }
    
    func addTotal(score: Int64, koin: Int64){
        let total = Total(context: context)
        total.koin = koin
        total.score = score
        save(context: context)
        
    }
    
    func getLatestTotal() -> Total? {
        let totalRequest = Total.fetchRequest()
        let total = try? context.fetch(totalRequest)
        return total?.first
    }

    
}
