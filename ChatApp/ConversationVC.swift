//
//  ConversationVC.swift
//  ChatApp
//
//  Created by Ronald Hernandez on 9/20/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

import UIKit
import Parse

var otherName = ""
var otherProfileName = ""

class ConversationVC: UIViewController, UIScrollViewDelegate{


    //create 3 arrays.
    var resultsUsernameArray = [String]()
    var resultsProfileNameArray = [String]()
    var resultsImageFilesArray = [PFFile]()

    @IBOutlet weak var resultsScrollView: UIScrollView!

    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var frameMessageView: UIView!

    var scrollViewOriginalY:CGFloat = 0
    var frameMessageOriginalY:CGFloat = 0

    var messageX:CGFloat = 37.0
    var messageY:CGFloat = 26.0
    var messageArray = [String]()
    var senderArray = [String]()



    let messageLabel = UILabel(frame: CGRect(x: 5, y: 8, width: 200, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()

        let theWidth = view.frame.width
        let theHeight = view.frame.height

        self.resultsScrollView.frame = CGRectMake(0, 64, theWidth, theHeight - 114)
        self.resultsScrollView.layer.zPosition = 20
        self.frameMessageView.frame = CGRectMake(0, self.resultsScrollView.frame.maxY, theWidth, 50)
        self.lineLabel.frame = CGRectMake(0, 0, theWidth, 1)
        self.messageTextView.frame = CGRectMake(0, 0, self.frameMessageView.frame.size.width-52, 48)

        self.sendButton.center = CGPointMake(self.frameMessageView.frame.size.width-30, 24)

        self.scrollViewOriginalY = self.resultsScrollView.frame.origin.y
        self.frameMessageOriginalY = self.frameMessageView.frame.origin.y

        self.title = otherProfileName

        self.messageLabel.text = "Please enter a message"
        self.messageLabel.backgroundColor = UIColor.clearColor()
        self.messageLabel.textColor = UIColor.lightGrayColor()
        self.messageLabel.frame = CGRectMake(0, 0, 100, 48)

        self.messageTextView.addSubview(self.messageLabel)

        //download messages
        self.refreshResults()


    }

    //function to download messages

    func refreshResults(){

        let theWidth = self.view.frame.size.width
        let theHeight = self.view.frame.size.height

        self.messageX = 37.0
        self.messageY = 26.0


        //EMPTY OUR ARRAYS.
        self.messageArray.removeAll(keepCapacity: false)
        self.senderArray.removeAll(keepCapacity: false)

        //CREATE SPECIAL PFQUERY 

        //1. create the first subquery. 

        let innerP1 = NSPredicate(format: "sender = %@ AND other = %@", (PFUser.currentUser()?.username)!, otherName)

        let innerQ1:PFQuery = PFQuery(className: "Message", predicate: innerP1)

        let innerP2 = NSPredicate(format: "sender = %@ AND other = %@", otherName, (PFUser.currentUser()?.username)!)

        let innnerQ2:PFQuery = PFQuery(className: "Message", predicate: innerP2)

        let mainQuery = PFQuery.orQueryWithSubqueries([innerQ1, innnerQ2])
        mainQuery.addAscendingOrder("createdAt")

        mainQuery.findObjectsInBackgroundWithBlock({ (results, error) -> Void in

            if error == nil {

            for object in results! {


                    print(object)

                    self.senderArray.append(object.objectForKey("sender") as! String)
                    self.messageArray.append(object.objectForKey("message") as! String)
                    
                }

                for  var i = 0; i <= self.messageArray.count - 1; i++ {

                    if self.senderArray[i] == PFUser.currentUser()?.username {
                        let messageLabel:UILabel = UILabel()

                        messageLabel.frame = CGRectMake(0, 0, self.resultsScrollView.frame.size.width-94, CGFloat.max)
                        messageLabel.backgroundColor = UIColor.orangeColor()
                        messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLabel.textAlignment = NSTextAlignment.Left
                        messageLabel.numberOfLines = 0
                        messageLabel.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLabel.textColor = UIColor.blackColor()
                        messageLabel.text = self.messageArray[i]
                        messageLabel.sizeToFit()
                        messageLabel.layer.zPosition = 20
                        messageLabel.frame.origin.x = (self.resultsScrollView.frame.size.width - self.messageX) - messageLabel.frame.size.width
                        messageLabel.frame.origin.y = self.messageY
                        self.resultsScrollView.addSubview(messageLabel)
                        self.messageY += messageLabel.frame.size.height + 30
                        self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.messageY)

                    }else{

                        let messageLabel:UILabel = UILabel()

                        messageLabel.frame = CGRectMake(0, 0, self.resultsScrollView.frame.size.width-94, CGFloat.max)
                        messageLabel.backgroundColor = UIColor.groupTableViewBackgroundColor()
                        messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLabel.textAlignment = NSTextAlignment.Left
                        messageLabel.numberOfLines = 0
                        messageLabel.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLabel.textColor = UIColor.blackColor()
                        messageLabel.text = self.messageArray[i]
                        messageLabel.sizeToFit()
                        messageLabel.layer.zPosition = 20
                        messageLabel.frame.origin.x = self.messageX
                        messageLabel.frame.origin.y = self.messageY
                        self.resultsScrollView.addSubview(messageLabel)
                        self.messageY += messageLabel.frame.size.height + 30
                        self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                    }
                }
            }else {
                print(error)
            }


        })

    }


    @IBAction func onSendButtonTapped(sender: UIButton) {

        
    }

}