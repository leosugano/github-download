//
//  DataBaseController.swift
//  StoneChallenge
//
//  Created by Leonardo Sugano on 05/04/23.
//

import Foundation
import CoreData

class DatabaseController {
    
    // MARK: - Constants
    private static let characterDataKey = "charactersData"
    private static let entityName = "Characters"
    private static let pageKey = "page"
    static let imageCache = NSCache<NSString, AnyObject>()
    
    private init() {}
    
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: entityName)
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch { }
        }
    }
    
    class func getAllCharacter() -> [CharacterDatasResponseModel] {
        let all = NSFetchRequest<NSManagedObject>(entityName: entityName)
        var allCharacters = [CharacterDatasResponseModel]()
        
        do {
            let fetched = try DatabaseController.getContext().fetch(all).first
            let data: Data? = fetched?.value(forKey: characterDataKey) as? Data
            
            if let data = data {
                allCharacters = try JSONDecoder().decode([CharacterDatasResponseModel].self, from: data)
            }
            
        } catch {
            let nserror = error as NSError
            print(nserror.description)
        }
        
        return allCharacters
    }
    
    class func getCharacterById(_ id: Int) -> CharacterDatasResponseModel? {
        let all = NSFetchRequest<NSManagedObject>(entityName: entityName)
        var character: CharacterDatasResponseModel?
        
        do {
            let fetched = try DatabaseController.getContext().fetch(all).first
            let data: Data? = fetched?.value(forKey: characterDataKey) as? Data
            
            if let data = data {
                let characters = try JSONDecoder().decode([CharacterDatasResponseModel].self, from: data)
                character = characters.filter({ character in
                    character.id == id
                }).first
            }
            
        } catch {
            let nserror = error as NSError
            print(nserror.description)
        }
        
        return character
    }
    
    class func getLastPage() -> Int {
        let all = NSFetchRequest<NSManagedObject>(entityName: entityName)
        var lastPage: Int = 0
        do {
            let fetched = try DatabaseController.getContext().fetch(all).first
            let page: Int? = fetched?.value(forKey: pageKey) as? Int
            
            if let page = page {
                lastPage = page
            }
            
        } catch {
            let nserror = error as NSError
            print(nserror.description)
        }
        
        return lastPage
    }
    
    class func deleteAllDatas() { 
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            try DatabaseController.getContext().execute(deleteALL)
            DatabaseController.saveContext()
        } catch {
            print("There is an error in deleting records")
        }
    }
    
    class func addCaracterAndLastPage(_ characters: [CharacterDatasResponseModel], lastPage: Int) {

        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(characters)
            
            let entity = NSEntityDescription.entity(forEntityName: "Characters", in: DatabaseController.getContext())
            let newShow = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
            
            newShow.setValue(jsonData, forKey: characterDataKey)
            newShow.setValue(lastPage, forKey: pageKey)
            
        } catch {
            
        }
    }
}
