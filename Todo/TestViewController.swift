//
//  TestViewController.swift
//  Todo
//
//  Created by Sean Moles on 05/08/2018.
//  Copyright © 2018 Sean Moles. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    var qtnArray = [String]()  //Empty array
    var numCount: Int = 0
    var num1: Int = 0
    var num2: Int = 0
    var answer: Int = 0
    var total: Int = 0
    
    
    
    @IBOutlet weak var textName: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var ansLbl: UILabel!
    @IBOutlet weak var QtnButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    let defaults = UserDefaults.standard  //Coredata variable to access data

    override func viewDidLoad() {
        super.viewDidLoad()
      
        if (self.defaults.object(forKey: name) != nil) {
            let alert = UIAlertController(title: "Results already saved for \(name)", message: "Press OK to retake test or cancel to return", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
 _ = self.navigationController?.popToRootViewController(animated: true)
                
            }
            alert.addAction(cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil )
            
        }

        
        
        
        
        qtnArray.append("\(name)")
        QtnButton.isHidden = false
        finishButton.isHidden = true
        showQuestion()
textName.text = name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearPressed(_ sender: Any) {
         ansLbl.text = "0"
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if ansLbl.text == "0" {
          ansLbl.text = sender.titleLabel?.text
            
        }else {
            ansLbl.text = "\(String(describing: ansLbl!.text!))\(String(describing: sender.titleLabel!.text!))"
                    }
    }

    @IBAction func newQuestion(_ sender: UIButton) {
        checkanswer()
        showQuestion()
    }
    
    func checkanswer() {
        if Int(ansLbl!.text!) == answer {
            total = total + 1
        }else {
             qtnArray.append("\(num1)x\(num2)=\(ansLbl.text!)")
        }
        ansLbl.text = "0"
    }

    func showQuestion() {
        
        numCount = numCount + 1
        num1 = Int(arc4random_uniform(12)+1)
        num2 = Int(arc4random_uniform(12)+1)
        answer = num1 * num2
        questionLbl.text = "Question \(numCount):          \(num1) x \(num2)"
        if numCount == numQtns {
            QtnButton.isHidden = true
            finishButton.isHidden = false
        }
    }
    
    @IBAction func finishPressed(_ sender: UIButton) {
        checkanswer()
        qtnArray.append("\(total) out of \(numCount)")
        finishButton.isHidden = true
        
        let alert = UIAlertController(title: "\(name)", message: "You scored \(total) out of \(numCount)", preferredStyle: .alert)
        self.defaults.set(self.qtnArray, forKey: name)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
             _ = self.navigationController?.popToRootViewController(animated: true)
        }
//        alert.addTextField { (alertTextField) in
//
//        }
         alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    
    
}



















