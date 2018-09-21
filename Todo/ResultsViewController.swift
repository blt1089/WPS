//
//  ResultsViewController.swift
//  Todo
//
//  Created by Sean Moles on 07/08/2018.
//  Copyright © 2018 Sean Moles. All rights reserved.
//

import UIKit
import CoreData
import MessageUI
class ResultsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var resultsView: UITextView!
  
    var itemArray = [String]()  //Empty array
    
    let defaults = UserDefaults.standard  //Coredata variable to access data


    override func viewDidLoad() {
        super.viewDidLoad()
       resultsView.isHidden = true
  
        var textField = UITextField()
        let alert = UIAlertController(title: "Password", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Login", style: .default) { (action) in
            if textField.text != String(2480) {
            _ = self.navigationController?.popToRootViewController(animated: true)
              
            }else {
                self.resultsView.isHidden = false
            }
        }
        //Add text field to Alert dialog box
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Password"
            textField = alertTextField
        }
        //Show Alert dialog box
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        if (self.defaults.object(forKey: "nameArray") != nil) {
            itemArray = defaults.array(forKey: "nameArray") as! [String]
        }
        
        for names in itemArray {
            
           if (self.defaults.object(forKey: names) != nil) {
            let res = defaults.array(forKey: names) as! [String]
            for info in res {
           resultsView.text.append("\(info)  ")
            }
            resultsView.text.append("\n\n")
        }
        }
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func printPressed(_ sender: Any) {
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfoOutputType.general
        printInfo.jobName = "My Print Job"
        
        // Set up print controller
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        
        // Assign a UIImage version of my UIView as a printing iten
        printController.printingItem = self.view.toImage()
        
        // Do it
        printController.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)

    }
    @IBAction func emailButtonPressed(_ sender: UIButton) {

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
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("Data")
        mailComposerVC.setMessageBody(resultsView.text!, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["sean.moles@gmail.com"])
            mail.setMessageBody("<p>Oops</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    }






extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
