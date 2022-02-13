

import UIKit

class ToDoViewController: UITableViewController {

   
        
        var itemArray = ["Choko Milk", "Voke Nea", "Zea Ke"]
        
    
    let defaults = UserDefaults.standard
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let items = defaults.array(forKey: "TodoListArray") as? [String] {
                itemArray = items
            }
        }
        
 //MARK: - TableView Datasourse Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

       cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
        
    
    //MARK: - TableView Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let indexPath = tableView.indexPathForSelectedRow

        // let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell?

        // print(currentCell?.textLabel!.text ?? "lea")
        
        if tableView.cellForRow(at: indexPath!)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath!)?.accessoryType = .none
            
        } else if tableView.cellForRow(at: indexPath!)?.accessoryType == UITableViewCell.AccessoryType.none {
            tableView.cellForRow(at: indexPath!)?.accessoryType = .checkmark
        }
        
       
        tableView.deselectRow(at: indexPath!, animated: true)
        
    }
    
   
   //MARK: - Add New Items
    
  
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //  what will happen once user clicks the Add Item button on our UIAlert
            self.itemArray.append(textField.text!)
            
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
            //  reload data tableview (update)
            self.tableView.reloadData()
            
        }
           
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil )
            
        }
    }
    
    
    
    
    




