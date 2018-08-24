//
//  ResultsViewController.swift
//  Todo
//
//  Created by Sean Moles on 07/08/2018.
//  Copyright © 2018 Sean Moles. All rights reserved.
//

import UIKit
import CoreData
class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsView: UITextView!
  
    var itemArray = [String]()  //Empty array
    
    let defaults = UserDefaults.standard  //Coredata variable to access data


    override func viewDidLoad() {
        super.viewDidLoad()
       
        if (self.defaults.object(forKey: "nameArray") != nil) {
            itemArray = defaults.array(forKey: "nameArray") as! [String]
        }
        
        for names in itemArray {
            
           if (self.defaults.object(forKey: names) != nil) {
            let res = defaults.array(forKey: names) as! [String]
            for info in res {
           resultsView.text.append("\(info),  ")
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
