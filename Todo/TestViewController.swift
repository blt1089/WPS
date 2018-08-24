//
//  TestViewController.swift
//  Todo
//
//  Created by Sean Moles on 05/08/2018.
//  Copyright © 2018 Sean Moles. All rights reserved.
//

import UIKit
import MessageUI

class TestViewController: UIViewController, MFMailComposeViewControllerDelegate {
    var qtnArray = [String]()  //Empty array
    var numCount: Int = 0
    var num1: Int = 0
    var num2: Int = 0
    var answer: Int = 0
    var total: Int = 0
    
    var gameTimer = Timer()
    var isTimerRunning = false
    
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
 
                self.defaults.removeObject(forKey: name)
                self.showQuestion()
                
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
 _ = self.navigationController?.popToRootViewController(animated: true)
                
            }
            alert.addAction(cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil )
            
        }else {
            self.showQuestion()
        }
        qtnArray.append("\(name)")
        QtnButton.isHidden = false
        finishButton.isHidden = true
        
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

    @IBAction func newQuestion() {
        gameTimer.invalidate()
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
        gameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(seconds), target: self, selector: #selector(timerRunOut), userInfo: nil, repeats: true)
    }
    
    @IBAction func finishPressed() {
        gameTimer.invalidate()
        
        finishButton.isHidden = true
        checkanswer()
        qtnArray.append("\(total) out of \(numCount) and \(seconds) Seconds per question")
        finishButton.isHidden = true
        
        let alert = UIAlertController(title: "\(name)", message: "You scored \(total) out of \(numCount)", preferredStyle: .alert)
        self.defaults.set(self.qtnArray, forKey: name)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
        self.email()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
//        alert.addTextField { (alertTextField) in
//
//        }
         alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    
    @objc func timerRunOut() {
         if numCount == numQtns {
           finishPressed()
        }else {
            newQuestion()
        }
    }
    func email() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["sean@wychall.bham.sch.uk"])
        mailComposerVC.setSubject("Data")
        let messageTxt: String = "\(qtnArray)"
        mailComposerVC.setMessageBody(messageTxt, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["sean.moles@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    
    }
}



















