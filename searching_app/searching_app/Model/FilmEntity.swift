//
//  FilmEntity.swift
//  searching_app
//
//  Created by Lizaveta Rudzko on 3/25/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import Foundation
import CoreData

class FilmEntity
{
    private var databaseObject: NSManagedObject?
    
    init(persistentContainer: NSPersistentContainer, title: String, amount: Int)
    {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FilmEnt")
        request.predicate = NSPredicate(format: "title = %@", title) 
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0
        {
            objects[0].setValue(amount, forKey: "amount")
        }
        try! managedContext.save()
    }
    
    init(persistentContainer: NSPersistentContainer, title: String, year: String, image: String, descript: String, score: Double, amount: Int)
    {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FilmEnt", in: managedContext)!
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(title, forKey: "title")
        databaseObject!.setValue(year, forKey: "year")
        databaseObject!.setValue(image, forKey: "image")
        databaseObject!.setValue(descript, forKey: "descript")
        databaseObject!.setValue(score, forKey: "score")
        databaseObject!.setValue(amount, forKey: "amount")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer)
    {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func title() -> String?
    {
        return databaseObject?.value(forKey: "title") as? String
    }
    
    func year() -> String?
    {
        return databaseObject?.value(forKey: "year") as? String
    }
    
    func image() -> String?
    {
        return databaseObject?.value(forKey: "image") as? String
    }
    
    func descript() -> String?
    {
        return databaseObject?.value(forKey: "descript") as? String
    }
    
    func score() -> Double?
    {
        return databaseObject?.value(forKey: "score") as? Double
    }
    
    func amount() -> Int?
    {
        return databaseObject?.value(forKey: "amount") as? Int
    }
    
}
