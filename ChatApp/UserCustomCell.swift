//
//  UserCustomCell.swift
//  ChatApp
//
//  Created by Ronald Hernandez on 9/20/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

import UIKit

class UserCustomCell: UITableViewCell {
    @IBOutlet weak var profileNameLabel: UILabel!

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

       let theWidth = UIScreen.mainScreen().bounds.width

        contentView.frame = CGRectMake(0, 0, theWidth, 120)
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.profileImage.clipsToBounds = true
        self.profileNameLabel.center = CGPointMake(230, 55)

    }

}
