//
//  ViewController.swift
//  ChatAppForTrial
//
//  Created by Oneinch on 2018/06/01.
//  Copyright © 2018年 Rina Unno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var messageField: UITextField!
    
    
    var databaseRef:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.delegate = self
        
        databaseRef = Database.database().reference()
        
        databaseRef.observe(DataEventType.childAdded, with: { snapshot in
            if let name = (snapshot.value! as AnyObject).object(forKey: "name") as? String,
                let message = (snapshot.value! as AnyObject).object(forKey: "message") as? String {
                self.textView.text! = "\(self.textView.text!)\n\(name) : \(message)"
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        let messageData = ["name": nameField.text!, "message": messageField.text!]
        
        databaseRef.childByAutoId().setValue(messageData)
        
        textField.resignFirstResponder()
        messageField.text = ""
        
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
