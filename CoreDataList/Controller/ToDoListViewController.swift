//
//  ToDoListViewController.swift
//  CoreDataList
//
//  Created by Jorge Armando Avila Estrada on 17/12/22.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var currentTask : Task?
    var dataManager : TaskDataManager?
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var toDoListTableView: UITableView!
    
    
    @IBOutlet weak var filterDateText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        
        // Set Date Format
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        setupTextFields()
        
        dataManager = TaskDataManager(context: context)
        dataManager!.fetch() //Todos los resultados
        //dataManager?.fetchWithPredicate(searchValue: "tarea") //Busqueda por algun parametro especifico
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataManager?.countTask())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoTaskCell",for: indexPath) as! ToDoTaskCell
        
        cell.taskTitle.text = dataManager?.getTask(at: indexPath.row).title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSegue"{
            let destination = segue.destination as! TaskDetailViewController
            destination.toDoDetailTask = dataManager?.getTask(at: toDoListTableView.indexPathForSelectedRow!.row)
            
        }
    }
    
    
    @IBAction func unWindFromDetail(segue: UIStoryboardSegue){
        let source = segue.source as! TaskDetailViewController
        currentTask = source.toDoDetailTask
        
        do{
            try context.save()
        }catch{
            print("Error al guardar")
        }
        
        dataManager?.fetch()
        self.toDoListTableView.reloadData()
        
    }
    

    //Eliminar
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskDelete = dataManager?.getTask(at: indexPath.row)
            print("borrar:"+taskDelete!.title)
            do{
                context.delete(taskDelete!)
                try context.save()
            }catch{
                print("Error al eliminar")
            }
        
            dataManager?.fetch()
            self.toDoListTableView.reloadData()
          
        }
    }
    
   
    @IBAction func filterByDate(_ sender: UITextField) {
        print("voy a buscar "+sender.text!)
        
        dataManager?.fetchWithPredicate(dateStart: dateFormatter.date(from: sender.text!+" 00:00") ?? nil, dateEnd: dateFormatter.date(from: sender.text!+" 23:59") ?? nil)
        self.toDoListTableView.reloadData()
        
    }
    
    
    
    
    func setupTextFields() {
                let toolbar = UIToolbar()
                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil, action: nil)
                let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                                 target: self, action: #selector(doneButtonTapped))
                
                toolbar.setItems([flexSpace, doneButton], animated: true)
                toolbar.sizeToFit()
                
            filterDateText.inputAccessoryView = toolbar
            
            }
        
        @objc func doneButtonTapped() {
               view.endEditing(true)
           }
    
    
}
