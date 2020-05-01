//
//  LoginViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 3/30/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
       if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    @IBAction func onLogin(_ sender: Any) {
        //Segue to FeedViewController
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (user != nil){
                //segue
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                UserDefaults.standard.set(true, forKey: "userLoggedIn")            } else {
                self.errorTextLabel.isHidden = false
                self.errorTextLabel.text = "Sorry please enter valid credentials or register :)"
                UIView.animate(withDuration: 3, animations: {self.errorTextLabel.alpha = 0}, completion: {_ in
                    self.errorTextLabel.alpha = 1
                    self.errorTextLabel.isHidden = true
                })
   
               
                print("error: \(error?.localizedDescription)")
            }
        }
        
    }
    @IBAction func registerNewAccount(_ sender: Any) {
        //Segue to register new account
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
