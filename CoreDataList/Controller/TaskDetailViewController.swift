//
//  TaskDetailViewController.swift
//  CoreDataList
//
//  Created by Jorge Armando Avila Estrada on 17/12/22.
//

import UIKit

class TaskDetailViewController: UITableViewController {

    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDate: UIDatePicker!
    @IBOutlet weak var taskNotes: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var toDoDetailTask : Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        
        if toDoDetailTask != nil{
            taskTitle.text = toDoDetailTask?.title
            taskDate.date = (toDoDetailTask?.date)!
            taskDate.date = (toDoDetailTask?.date)!
            taskNotes.text = toDoDetailTask?.notes
        }else{
            toDoDetailTask = Task(context: context) //Nueva instancia
            taskTitle.text = "" //Solo por si el usuario no registra información
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        
        toDoDetailTask?.title = taskTitle.text!
        toDoDetailTask?.date = taskDate.date
        toDoDetailTask?.notes = taskNotes.text!
        
        destination.currentTask = toDoDetailTask!
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        if validateText(text: taskTitle.text!){
            perform = true
        }else{
            
            userMessage(alertTitle: "Datos", message: "Título es requerido", actionTitle: "Ok", vc: self)
            
            
        }
        return perform
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let isModal = self.presentingViewController is UINavigationController
        
        if isModal{
            self.dismiss(animated: true)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    func userMessage(alertTitle:String, message: String, actionTitle:String, vc:UITableViewController){
        
        let alertMessage = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: actionTitle, style: .default)
        
        alertMessage.addAction(okAction)
        vc.present(alertMessage, animated: true)
        
    }
    
    
    func setupTextFields() {
                let toolbar = UIToolbar()
                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil, action: nil)
                let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                                 target: self, action: #selector(doneButtonTapped))
                
                toolbar.setItems([flexSpace, doneButton], animated: true)
                toolbar.sizeToFit()
                
        taskTitle.inputAccessoryView = toolbar
        taskNotes.inputAccessoryView = toolbar
            
            }
        
        @objc func doneButtonTapped() {
               view.endEditing(true)
           }
    
}
