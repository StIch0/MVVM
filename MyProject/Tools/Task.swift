//
//  Task.swift
//  MyProject
//
//  Created by Dev on 24.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import CoreData
@available(iOS 13.0, *)
class Task: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Task] {
        let request : NSFetchRequest<Task> = Task.fetchRequest() as! NSFetchRequest<Task>
        request.sortDescriptors = [NSSortDescriptor(key: "taskName", ascending: true)]
        guard let tasks = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return tasks
    }

    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        Task.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
        try? viewContext.save()
    }
}

