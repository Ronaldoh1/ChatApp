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

    var myImage:UIImage = UIImage()
    var otherImage:UIImage = UIImage()

    //need two arrays to hold ImageFiles

    var resultsImageFiles = [PFFile]()
    var resultsImageFiles2 = [PFFile]()


    var scrollViewOriginalY:CGFloat = 0
    var frameMessageOriginalY:CGFloat = 0

    var messageX:CGFloat = 37.0
    var messageY:CGFloat = 26.0
    var frameX:CGFloat = 32.0
    var frameY:CGFloat = 21.0

    var imgX:CGFloat = 3.0
    var imgY:CGFloat = 3.0

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
       // self.refreshResults()


    }

    override func viewDidAppear(animated: Bool) {
        let query = PFQuery(className: "_User")

        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock({ (results, error) -> Void in

            if error == nil {

                self.resultsImageFiles.removeAll(keepCapacity: false)

                for object in results! {


                self.resultsImageFiles.append(object["photo"] as! PFFile)



                self.resultsImageFiles[0].getDataInBackgroundWithBlock({ (imageData, error) -> Void in

                        if error == nil {
                            self.myImage = UIImage(data: imageData!)!

                            let query2 = PFQuery(className: "_User")
                            query2.whereKey("username", equalTo: otherName)



                            query2.findObjectsInBackgroundWithBlock({ (results2, error) -> Void in

                                if error == nil {
                                    self.resultsImageFiles.removeAll(keepCapacity: false)

                                    for object in results2! {

                                        self.resultsImageFiles2.append(object["photo"] as! PFFile)

                                        self.resultsImageFiles2[0].getDataInBackgroundWithBlock({ (imageData2, error) -> Void in

                                            if error == nil {

                                                self.otherImage = UIImage(data: imageData2!)!

                                                self.refreshResults()

                                            }


                                        })

                                    }
                                    
                                }
                            })


                        }
                    })


                }


            }
        })
    }

    //function to download messages

    func refreshResults(){

        let theWidth = self.view.frame.size.width
        let theHeight = self.view.frame.size.height

        self.messageX = 37.0
        self.messageY = 26.0
        self.frameX = 32.0
        self.frameY = 21.0

        self.imgX = 3.0
        self.imgY = 3.0





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

                for subView in self.resultsScrollView.subviews{
                     self.resultsScrollView.willRemoveSubview(subView)
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

                        let frameLabel:UILabel = UILabel()
                        frameLabel.frame.size  = CGSizeMake(messageLabel.frame.size.width+10, messageLabel.frame.size.height+10)

                        frameLabel.frame.origin.x = (self.resultsScrollView.frame.size.width - self.frameX) - frameLabel.frame.size.width
                        frameLabel.frame.origin.y = self.frameY
                        frameLabel.backgroundColor = UIColor.orangeColor()
                        frameLabel.layer.masksToBounds = true
                        frameLabel.layer.cornerRadius = 10
                        self.resultsScrollView.addSubview(frameLabel)
                        self.frameY += frameLabel.frame.size.height + 20


                        let img:UIImageView = UIImageView()

                        img.image = self.myImage
                        img.frame.size = CGSizeMake(34, 34)
                        img.frame.origin.x = (self.resultsScrollView.frame.size.width - self.imgX) - img.frame.size.width
                        img.frame.origin.y = self.imgY
                        img.layer.zPosition = 30
                        img.layer.cornerRadius = img.frame.size.width/2
                        img.clipsToBounds = true
                        self.resultsScrollView.addSubview(img)
                        
                        self.imgY += frameLabel.frame.size.height + 20

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

                        let frameLabel:UILabel = UILabel()
                        frameLabel.frame  = CGRectMake(self.frameX, self.frameY, messageLabel.frame.size.width + 10, messageLabel.frame.size.height + 10)
//                        frameLabel.frame.origin.x = (self.resultsScrollView.frame.size.width - self.frameX) - frameLabel.frame.size.width
//                        frameLabel.frame.origin.y = self.frameY
                        frameLabel.backgroundColor = UIColor.groupTableViewBackgroundColor()
                        frameLabel.layer.masksToBounds = true
                        frameLabel.layer.cornerRadius = 10
                        self.resultsScrollView.addSubview(frameLabel)
                        self.frameY += frameLabel.frame.size.height + 20


                        let img:UIImageView = UIImageView()

                        img.image = self.otherImage
                        img.frame = CGRectMake(self.imgX, self.imgY, 34, 34)
                        img.layer.zPosition = 30
                        img.layer.cornerRadius = img.frame.size.width/2
                        img.clipsToBounds = true
                        self.resultsScrollView.addSubview(img)

                        self.imgY += frameLabel.frame.size.height + 20

                        self.resultsScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                    }

                    let bottomOffSet:CGPoint = CGPointMake(0, self.resultsScrollView.contentSize.height - self.resultsScrollView.bounds.size.height)
                    self.resultsScrollView.setContentOffset(bottomOffSet, animated: false)
                }
            }else {
                print(error)
            }


        })

    }


    @IBAction func onSendButtonTapped(sender: UIButton) {


    }

}