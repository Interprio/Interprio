//
//  RegisterViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 4/2/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func registerAccount(_ sender: Any) {
        
        // Verify no fields are empty
        if (emailTextField.text!.isEmpty
            || usernameTextField.text!.isEmpty
            || passwordTextField.text!.isEmpty
            || verifyPasswordTextField.text!.isEmpty) {
            
            return
            
        }
        // Verify matching passwords
        if (passwordTextField.text! != verifyPasswordTextField.text!){
            
            return
        }
        // create user
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        
        //set image
        let image = UIImage(named: "interprio_logo")
        let imageData = (image!.pngData())
        let imageFile = PFFileObject(name: "profileLogo.png", data: imageData!)
        let userPhoto = PFObject(className: "User")
        user["profilePicture"] = imageFile
        
        //sign up
        user.signUpInBackground { (success, error) in
            if(success) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func cancelSignup(_ sender: Any) {
        
        
        [self .dismiss(animated: true, completion: nil)]
        
    }
    

    
}
