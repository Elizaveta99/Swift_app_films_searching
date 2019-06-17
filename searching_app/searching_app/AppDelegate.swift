//
//  AppDelegate.swift
//  searching_app
//
//  Created by Lizaveta Rudzko on 3/24/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce")
        {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "Film1", year: "2005", image: "1.jpg", descript: "Doctor WHO. 1 season", score: 8.0, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "Film2", year: "2006", image: "2.jpg", descript: "Doctor WHO. 2 season", score: 9.3, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "Film3", year: "2007", image: "3.jpg", descript: "Doctor WHO. 3 season", score: 9.1, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "Film11(4)", year: "2008", image: "4.jpg", descript: "Doctor WHO. 4 season", score: 9.2, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "DoctorWho_Film5", year: "2010", image: "5.jpg", descript: "Doctor WHO. 5 season", score: 8.9, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "IAmTheDoctor(Film6)", year: "2011", image: "6.jpg", descript: "Doctor WHO. 6 season", score: 9.2, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "Film7", year: "2012", image: "7.jpg", descript: "Doctor WHO. 7 season", score: 9.8, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "Allonsy_Film8", year: "2014", image: "8.jpg", descript: "Doctor WHO. 8 season", score: 9.7, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "Fantastic_Film9", year: "2015", image: "9.jpg", descript: "Doctor WHO. 9 season", score: 8.9, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "TheLastDoctor_Film10", year: "2017", image: "10.jpg", descript: "Doctor WHO. 10 season", score: 9.6, amount: 0)
            var _: FilmEntity = FilmEntity(persistentContainer: persistentContainer, title: "ThisDoctorIsTooCool_Film11", year: "2018", image: "11.jpg", descript: "Doctor WHO. 11 season", score: 9.5, amount: 0)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "searching_app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

