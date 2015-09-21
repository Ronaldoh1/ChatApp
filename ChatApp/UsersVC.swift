//
//  UsersVC.swift
//  ChatApp
//
//  Created by Ronald Hernandez on 9/20/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

import UIKit
import Parse

var currentUser = ""

class UsersVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    //create 3 arrays. 
    var resultsUsernameArray = [String]()
    var resultsProfileNameArray = [String]()
    var resultsImageFilesArray = [PFFile]()


    override func viewDidLoad() {
        super.viewDidLoad()

        //we need to get the width and the height of screen.
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height

        self.tableView.frame = CGRectMake(0, 0, theHeight, theHeight - 64)

        currentUser = (PFUser.currentUser()?.username)!


        //download contacts

        self.downloadContacts()
        
    }

    override func viewDidAppear(animated: Bool) {

            
        }
//
//
//        query.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
//
//            for result in results! {
////
//
//
//            }
//
//
//    })


    func downloadContacts(){

        let query = User.query()
        //check that the current user isn't included.

        query?.whereKey("username", notEqualTo: currentUser)

        query?.findObjectsInBackgroundWithBlock({ (results, error) -> Void in

            for result in results! {

              let user = result as! PFUser

                print(user)

                self.resultsUsernameArray.append(user.username!)
                self.resultsProfileNameArray.append(user["profileName"] as! (String))

                let imageFile = result["photo"] as! PFFile
                self.resultsImageFilesArray.append(imageFile)

            }

            self.tableView.reloadData()
            })

//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//
//                    imageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
//
//                        if error != nil {
//                            print(error)
//                        }else{
//                            dispatch_async(dispatch_get_main_queue()) { // 2
//
//                                if let data = imageData {
//
//
//                                    self.resultsImageFilesArray.append(UIImage(data: data)!)
//
//                                    self.tableView.reloadData()
//                                    
//                                    
//                                    
//                                }
//                            }
//                        }
//                        
//                    })
//                })
//                
//            }
//
//        })

        
        
    }




    @IBAction func logOutButtonTapped(sender: AnyObject) {

        PFUser.logOut()

        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.resultsUsernameArray.count
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 120
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:UserCustomCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UserCustomCell


        cell.userNameLabel.text = self.resultsUsernameArray[indexPath.row]
        cell.profileNameLabel.text = self.resultsProfileNameArray[indexPath.row]

        let imageFile:PFFile = self.resultsImageFilesArray[indexPath.row]


        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

            imageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in

                if error != nil {
                    print(error)
                }else{
                    dispatch_async(dispatch_get_main_queue()) { // 2

                        if let data = imageData {

                            cell.profileImage.image = UIImage(data: data)


                        }
                    }
                }
                
            })
        })






        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cell:UserCustomCell = tableView.cellForRowAtIndexPath(indexPath) as! UserCustomCell

        otherName = cell.userNameLabel.text!;
        otherProfileName = cell.profileNameLabel.text!
        self.performSegueWithIdentifier("toConversation", sender: self)
    }



}
