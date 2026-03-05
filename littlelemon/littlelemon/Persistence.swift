import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ExampleDatabase")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: {_,_ in })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
    }
    
    func clearAsync() async throws {
        print("clearAsync started")
        
        let backgroundContext = container.newBackgroundContext()
        //print("Created background context")
        
        try await backgroundContext.perform {
            //print("Inside perform block")
            
            let fetchRequest = NSFetchRequest<Dish>(entityName: "Dish")
            fetchRequest.includesPropertyValues = false  // optimize: don't load full objects
            fetchRequest.fetchBatchSize = 50             // efficient batching
            
            let objects = try backgroundContext.fetch(fetchRequest)
            //print("Found \(objects.count) Dish objects to delete")
            
            for dish in objects {
                backgroundContext.delete(dish)
            }
            
            try backgroundContext.save()
            //print("Deleted \(objects.count) Dish objects and saved background context")
        }
        
        // Refresh main context to reflect deletion
        try await MainActor.run {
            container.viewContext.refreshAllObjects()
            let mainCount = try container.viewContext.count(for: Dish.fetchRequest())
            print("Main context count after clear: \(mainCount) (should be 0)")
        }
        
        print("clearAsync finished")
    }

}
