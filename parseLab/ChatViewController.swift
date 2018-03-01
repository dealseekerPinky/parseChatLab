//
//  ChatViewController.swift
//  parseLab
//
//  Created by Pinky Kohsuwan on 2/22/18.
//  Copyright © 2018 Pinky Kohsuwan. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // declare this as an optional array ( array of PFcjects tht can be nil)
    // to be safe we initalize as an empty array
    var chatMessageList :[PFObject] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return chatMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatsList.dequeueReusableCell(withIdentifier: "MessageCell", for : indexPath) as! MessageCell
        let wholeMessage = chatMessageList[indexPath.row]
        cell.message.text = wholeMessage["text"] as? String
        if let user = wholeMessage["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
    }
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBOutlet weak var chatsList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsList.delegate = self
        chatsList.dataSource = self
        
        // Auto size row height based on cell autolayout constraints
        chatsList.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        chatsList.estimatedRowHeight = 50
        //fetchMessages()
        //chatsList.reloadData()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)

        
    }
    
    @IBAction func clickSend(_ sender: Any) {
        sendChatMessage()
        //fetchMessages()
        chatsList.reloadData()

    }

    //When the user taps the "Send" button, create a new Message of type PFObject and save it to Parse
    func sendChatMessage()
    {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
        if success {
            print("The message was saved!")
            self.chatMessageField.text = ""
        } else if let error = error {
        print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }

    @objc func fetchMessages() {
        // Fetch messages from Parse
        print("Timer running")
        //onTimer()
        //let predicate = NSPredicate(format: "likesCount > 100")

        let query = PFQuery(className: "Message")
       // query.limit = 50
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        //query.includeKey("author")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects{
                print("saved messages")
                self.chatMessageList = objects
                print("\(String(describing: self.chatMessageList.first!["text"]!))")
                self.chatsList.reloadData()
            } else {
                print("Error from chat view controller trying to get messages in fetchMessages() function with localized description \"\(error!.localizedDescription)\"")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)

    }
    

}
