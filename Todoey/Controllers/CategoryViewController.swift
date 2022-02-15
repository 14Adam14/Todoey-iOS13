

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    
    
    var category = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    loadItems()

    }


    
    


//MARK: - TableView Datasource Methods



    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)


        let item = category[indexPath.row]

        cell.textLabel?.text = item.name


        
        
        return cell
    }
    
    
    

//MARK: - Data Manipulation Methods

    
    func saveItems() {
        
        
        
        do {
            
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    
    
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            
         category = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
        }
    
    
    
    
    
    
//MARK: - Add New Categories

    
@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    var textField = UITextField()
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        //  what will happen once user clicks the Add Item button on our UIAlert
        
        
        
        let newItem = Category(context: self.context)
        newItem.name = textField.text!
        
        
        self.category.append(newItem)
        
        self.saveItems()
        
    }
    
    alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
    }
    
    alert.addAction(action)
    
    self.present(alert, animated: true, completion: nil )
    

}
    

    

//MARK: - TableView Delegate Methods

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    




}
