import UIKit
var name = ""
var numQtns = 24
var seconds = 15
class TodoViewController: UITableViewController {

    @IBOutlet weak var countDownButton: UIBarButtonItem!
    @IBOutlet weak var questions: UIBarButtonItem!
    var itemArray = [String]()  //Empty array
    
    let defaults = UserDefaults.standard  //Coredata variable to access data
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        
        // Check if CoreData exists, if so, copy to questions and time
        if (self.defaults.object(forKey: "countDown") == nil) {
            self.defaults.set(seconds, forKey: "countDown")
        }else {
            seconds = Int(defaults.integer(forKey: "countDown"))
        }
        countDownButton.title = "\(seconds) seconds per question"
        
        
        if (self.defaults.object(forKey: "qtns") == nil) {
            self.defaults.set(numQtns, forKey: "qtns")
        }else {
            numQtns = Int(defaults.integer(forKey: "qtns"))
        }
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
            if textField.text! == "" {
                
            }else {
                
            
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "nameArray")
            self.tableView.reloadData()
        }
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
                self.defaults.set(numQtns, forKey: "qtns")
                self.questions.title = "\(numQtns) Questions"
            
                
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

 
    @IBAction func countPressed(_ sender: Any) {
    
    var textFieldCount = UITextField()
        let alert = UIAlertController(title: "Number of Seconds", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Set Time", style: .default) { (action) in
            //When count clicked, set seconds
            if let counts: Int = Int(textFieldCount.text!) {
                seconds = counts
                self.defaults.set(seconds, forKey: "countDown")
                self.countDownButton.title = "\(seconds) Seconds per Question"
                
                
              
                
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Number"
            textFieldCount = alertTextField
        }
        //Show Alert dialog box
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
    
    }
}











