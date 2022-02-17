

import UIKit
import RealmSwift



class CategoryViewController: SwipeTableViewController {

    
    let realm = try! Realm()
    
    
    var category : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     loadCategories()
        
        tableView.rowHeight = 80.0

    }


    
    


//MARK: - TableView Datasource Methods



    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }

    

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = category?[indexPath.row].name ?? "No Categories Added yet"

        
        return cell
    }
    
    
    
    
    //MARK: - TableView Delegate Methods

        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            performSegue(withIdentifier: "goToItems", sender: self)
            
        }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = category?[indexPath.row]
        }
        
    }
    
    
    
    
    
    
    

//MARK: - Data Manipulation Methods

    
    func save(category: Category) {
        
        do {
            try realm.write {
            realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    
    
    func loadCategories() {
        
        category = realm.objects(Category.self)
        
        tableView.reloadData()
        
        }
    
//MARK: - Delete Data
    
    
    override func updateModel(at IndexPath: IndexPath) {
        
        
        if let categoryForDeletion = self.category?[IndexPath.row] {
            
            do {
                try  self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
            
            
            
        }
        
    }

    
    
//MARK: - Add New Categories

    
@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    var textField = UITextField()
    
    let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
        //  what will happen once user clicks the Add Item button on our UIAlert
        
        
        
        let newCategory = Category()
        newCategory.name = textField.text!

        self.save(category: newCategory)
        
    }
    
    alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
    }
    
    alert.addAction(action)
    
    self.present(alert, animated: true, completion: nil )
    

}



}



