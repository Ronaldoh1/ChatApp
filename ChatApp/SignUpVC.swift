//
//  SignUpVC.swift
//  ChatApp
//
//  Created by Ronald Hernandez on 9/20/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var SignUp: UIButton!

    @IBOutlet weak var profileNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let theWidth = view.frame.size.width
      //  let theHeight = view.frame.size.height

        self.profileImage.center  = CGPointMake(theWidth / 2 , 140)
        //make profile image circle 
        self.profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        self.profileImage.clipsToBounds = true


        self.addImageButton.center = CGPointMake(self.profileImage.frame.maxX+50, 140)
        self.emailTextField.frame = CGRectMake(16, 230, theWidth-32, 30)
        self.passwordTextField.frame = CGRectMake(16, 270, theWidth-32, 30)
        self.profileNameTextField.frame = CGRectMake(16, 310, theWidth-32, 30)
        self.SignUp.center = CGPointMake(theWidth/2, 380)


    }
    
    @IBAction func addImageButtonTapped(sender: UIButton) {

            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image.allowsEditing = true
            self.presentViewController(image, animated: true, completion:nil)


        
    }
    //Image Picker Delegate method - dismiss image view controller and profile image to the one chosen.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
      self.profileImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //Dissmiss Keyboard when the user clicks return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.profileNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()

        return true
    }

    //Dismiss Keyboard when the user taps outside. 

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    //move the textfield when the keyboard shows up and put it back when the user finishes editing. 
    func textFieldDidBeginEditing(textField: UITextField) {
        let theWidth = self.view.frame.size.width
        let theHeight = self.view.frame.size.height

        if UIScreen.mainScreen().bounds.height == 568 {
            if (textField == self.profileNameTextField){
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                    self.view.center = CGPointMake(theWidth/2, (theHeight/2) - 40)
                    }, completion: {
                        (finished: Bool) in


                })
        }
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        let theWidth = self.view.frame.size.width
        let theHeight = self.view.frame.size.height

        if UIScreen.mainScreen().bounds.height == 568 {
            if (textField == self.profileNameTextField){
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                    self.view.center = CGPointMake(theWidth/2, (theHeight/2))
                    }, completion: {
                        (finished: Bool) in

                        
                })
            }
        }
    }
    @IBAction func signUpButtonTapped(sender: UIButton) {


        let user = PFUser()
        user.username = self.emailTextField.text;
        user.password = self.passwordTextField.text;
        user.email = self.emailTextField.text;

        user["profileName"] = profileNameTextField.text

        let imageData = UIImagePNGRepresentation(self.profileImage.image!)

        let imageFile = PFFile(name: "profilePhoto.png", data: imageData!)

        user["photo"] = imageFile

        user.signUpInBackgroundWithBlock { (succeeded:Bool, signUpError: NSError?) -> Void in

            if signUpError == nil {
                
                print("you got it!")
                  self.performSegueWithIdentifier("goToUsersVC2", sender: self)
                }else {

                print("can't sign up")

            }


        }





        
    }
}