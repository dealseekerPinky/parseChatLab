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
    var messages = [PFObject(className: "Message")]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil{
            return messages.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatsList.dequeueReusableCell(withIdentifier: "MessageCell", for : indexPath) as! MessageCell
        //cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBOutlet weak var chatsList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsList.delegate = self
        chatsList.dataSource = self
        //chatsList.reloadData()
        
        // Auto size row height based on cell autolayout constraints
        chatsList.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        chatsList.estimatedRowHeight = 50
        
    }
    
    @IBAction func clickSend(_ sender: Any) {
        sendChatMessage()
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
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if let messages = messages {
                print("saved messages")
                self.messages = messages
                print("\(String(describing: self.messages?.first!["text"]!))")
                self.tableView.reloadData()
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
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)

    }
    

}
