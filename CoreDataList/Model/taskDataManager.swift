//
//  taskDataManager.swift
//  CoreDataList
//
//  Created by Jorge Armando Avila Estrada on 17/12/22.
//

import Foundation
import CoreData


class TaskDataManager{
    private var tasks : [Task] = []
    private var context : NSManagedObjectContext

    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func fetch(){
        do{
            self.tasks = try self.context.fetch(Task.fetchRequest()) //Select all
            print(self.tasks.count)
        }catch{
            print("Error : ", error)
        }
    }
    
    //Predicado title
    func fetchWithPredicate(searchValue: String){
        do{
            let fetchRequestWP = NSFetchRequest<Task>(entityName: "Task")
            fetchRequestWP.predicate = NSPredicate(format: "title = %@", searchValue)
            self.tasks = try self.context.fetch(fetchRequestWP)
        }catch{
            print("Error:", error)
        }
    }
    
    //Predicado title
    func fetchWithPredicate(dateStart: Date?, dateEnd: Date?){
        if(dateStart == nil || dateEnd == nil){
            self.tasks = []
        }else{
            do{
                let fetchRequestWP = NSFetchRequest<Task>(entityName: "Task")
                fetchRequestWP.predicate = NSPredicate(format: "date >  %@ AND date < %@", dateStart! as NSDate, dateEnd! as NSDate)
                self.tasks = try self.context.fetch(fetchRequestWP)
            }catch{
                print("Error:", error)
            }
        }
        
    }
    
    
    func getTask(at index: Int) -> Task{
        return tasks[index]
    }
    
    func countTask() -> Int{
        return tasks.count
    }
    
}
