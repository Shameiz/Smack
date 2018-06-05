//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-01.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //IBOutlets and actions
    @IBOutlet weak var avatarPic: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBAction func backgroundPressed(_ sender: Any) {
    }
    @IBAction func chooseAvatarPress(_ sender: Any) {
    }
    @IBAction func createAccPressed(_ sender: Any) {
        guard let name = usernameText.text, usernameText.text != "" else{return}
        guard let email = emailText.text, emailText.text != "" else{return}
        guard let pass = passwordText.text, passwordText.text != "" else{return}
        spinner.isHidden = false;
        spinner.startAnimating()
        AuthService.instance.registerUser(email: email, password: pass){
            (success) in
            if(success){
                AuthService.instance.loginUser(email: email, password: pass){
                    (success) in
                    if(success){
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if(success){
                                self.spinner.isHidden=true;
                                self.spinner.stopAnimating();
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                }
            }
        }
        
    }
    
    @IBAction func dismissAccountPage(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    //override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));
        view.addGestureRecognizer(tap)
        
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //objc functions
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

}
