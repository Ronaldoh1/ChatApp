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

    @IBOutlet weak var tableView: UITableView!

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

    let messageLabel = UILabel(frame: CGRect(x: 5, y: 8, width: 200, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()

        let theWidth = view.frame.width
        let theHeight = view.frame.height

        self.resultsScrollView.frame = CGRectMake(0, 64, theWidth, theHeight - 114)
        self.resultsScrollView.layer.zPosition = 20
        //self.frameMessageView.frame = CGRectMake(0, self.resultsScrollView.frame.maxY, theWidth, 50)
        //self.lineLabel.frame = CGRectMake(0, 0, theWidth, 1)
        //self.messageTextView.frame = CGRectMake(2, 1, self.frameMessageView.frame.size.width-32, 48)

        //self.sendButton.center = CGPointMake(self.frameMessageView.frame.size.width-30, 24)

        self.scrollViewOriginalY = self.resultsScrollView.frame.origin.y
        //self.frameMessageOriginalY = self.frameMessageView.frame.origin.y

        self.title = otherProfileName

//        self.messageLabel.text = "Please enter a message"
//        self.messageLabel.backgroundColor = UIColor.clearColor()
//        self.messageLabel.textColor = UIColor.lightGrayColor()
//        self.messageTextView.addSubview(self.messageLabel)
    }
 


}