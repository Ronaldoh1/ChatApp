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

class ConversationVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    //create 3 arrays.
    var resultsUsernameArray = [String]()
    var resultsProfileNameArray = [String]()
    var resultsImageFilesArray = [PFFile]()


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!

        return cell
    }
}