//
//  ChatController.swift
//  SelfieTag
//
//  Created by Shaw on 2015-09-19.
//  Copyright (c) 2015 Shaw. All rights reserved.
//
//  Created by Jason Du
//  Copyright (c) 2015 Jason Du. All rights reserved.
//

import UIKit
import Firebase


class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    var items: [String] = ["We", "Heart", "Swift"]
    var names: [String] = ["a", "b", "b"]
    var chatRef: Firebase!
    
    @IBOutlet weak var messageBox: UITextField!
    
    @IBAction func sendButton(sender: AnyObject) {
        println(messageBox.text)
        var message = ["name": userName, "message": messageBox.text]
        let post1Ref = chatRef.childByAutoId()
        post1Ref.setValue(message)
        messageBox.text = ""
        tableViewScrollToBottom(true)
        tableView.reloadData()
        
    }
    
    func lightFire() {
        
        
        // Get a reference to our posts
        chatRef = Firebase(url:"https://blistering-torch-3319.firebaseio.com/chat/a-b")
        
        
        
//        chatRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
//            println(snapshot.childrenCount) // I got the expected number of items
//            let enumerator = snapshot.children
//            while let rest = enumerator.nextObject() as? FDataSnapshot {
//                println(rest.value)
//                var name = rest.value["name"] as? String
//                var message = rest.value["message"] as? String
//                println(name)
//                println(message)
//                
//                self.items.append(message!)
//                self.names.append(name!)
//                self.tableView.reloadData()
//            }
//            
//            }, withCancelBlock: { error in
//                println(error.description)
//        })
        
        
        // Retrieve new posts as they are added to the database
        chatRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            println("added -> \(snapshot.value)")
            var name = snapshot.value["name"] as? String
            var message = snapshot.value["message"] as? String
            println(name)
            println(message)
            
            if message != nil {
            self.items.append(message!)
            self.names.append(name!)
            self.tableView.reloadData()
            }
        })
        
    }
    
    
    override func viewDidLoad() {
        let imageView = UIImageView(image: UIImage(named: "blah"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        lightFire()
        
        println("hii");
        tableViewScrollToBottom(true)

        
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
            //self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        if self.names[indexPath.row] == userName {
            cell.textLabel?.textAlignment=NSTextAlignment.Right;
        }
        
        return cell
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.tableView.numberOfSections()
            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }


}



