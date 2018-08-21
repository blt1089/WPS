import UIKit
var name = ""
var numQtns = 24
class TodoViewController: UITableViewController {

    @IBOutlet weak var questions: UIBarButtonItem!
    var itemArray = [String]()  //Empty array
    
    let defaults = UserDefaults.standard  //Coredata variable to access data
    override func viewDidLoad() {
        
        super.viewDidLoad()
        questions.title = "\(numQtns) Questions"
        
    // Check if CoreData exists, if so, copy to array variable
        if (self.defaults.object(forKey: "nameArray") != nil) {
            itemArray = defaults.array(forKey: "nameArray") as! [String]
            
        }
    }
    // Create table cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    // Populate cells with array data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    // when cell selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        name = itemArray[indexPath.row]
        //Goto TestViewController with cell name sent
        performSegue(withIdentifier: "Transition", sender: itemArray[indexPath.row])    }

    
    
    //delete cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeName = String(itemArray[indexPath.row])
            if (self.defaults.object(forKey: removeName) != nil) {
             self.defaults.removeObject(forKey: itemArray[indexPath.row])
            }
                itemArray.remove(at: indexPath.row)
                self.defaults.set(self.itemArray, forKey: "nameArray")
            
            self.tableView.reloadData()
        }
    }
    
    
    
    
    //When plus bar item selected
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "New pupil", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add pupil", style: .default) { (action) in
    //When Add pupil clicked, add textfield.text to Array then copy array to Coredata
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "nameArray")
            self.tableView.reloadData()
        }
    //Add text field to Alert dialog box
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Full Name"
            textField = alertTextField
        }
    //Show Alert dialog box
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
        
    }
    
    @IBAction func questionsPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Number of Questions", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Set Questions", style: .default) { (action) in
            //When Add pupil clicked, set answer to numQtns and rename button
            if let ans: Int = Int(textField.text!) {
                numQtns = ans
                self.questions.title = "\(numQtns) Questions"
            print(numQtns)
                
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Number"
            textField = alertTextField
        }
        //Show Alert dialog box
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated) // No need for semicolon
//viewDidLoad()
//    }
//



}











