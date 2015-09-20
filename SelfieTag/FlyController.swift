//
//  FlyController.swift
//  
//
//  Created by Shaw on 2015-09-19.
//
//

import UIKit

class FlyControlller: UIViewController, UITableViewDelegate, UITableViewDataSource
 {
    
    @IBOutlet var tableView: UITableView!
    
    var names: [String] = ["Tim Zhang", "Kasra Koushan", "Shaw Tan", "Kingsong Chen", "Kelly Kong", "Annu Puri", "Umesh Kumar Khanna", "Eric Wu", "Chris Zhang"]
    let pic: [String] = ["tim.jpg", "kasra.jpg", "shaw.jpg", "kingsong.jpg", "kelly.jpg", "annu.jpg", "umesh.jpg", "eric.jpg", "chris.jpg"]
    
//    override func viewDidLoad() {
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        
////        tableView.delegate = self
//        //        tableView.dataSource = self
//        self.tableView.reloadData()
//        
//        
//    }
//    
//    @IBOutlet var tableView: UITableView!
//    var items: [String] = ["We", "Heart", "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.names[indexPath.row]
        cell.imageView?.image = UIImage(named: pic[indexPath.row])!

        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 70;//Choose your custom row height
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
        
        
        
    }
    
    
}
