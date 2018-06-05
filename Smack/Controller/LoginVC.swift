//
//  LoginVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-02-27.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //IBOutlets and actions
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let usernameText = username.text, username.text != "" else{return}
        guard let passwordText = password.text, password.text != "" else{return}
        
        AuthService.instance.loginUser(email: usernameText, password: passwordText) { (success) in
            if(success){
                AuthService.instance.findByUserEmail(completion: { (sucess) in
                    if(success){
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil);
                        self.spinner.isHidden=true;
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        return;
                    }
                })
            }
            else{
                return;
            }
        }
        
        
    }
    
    //override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //class functions
    
    func setUpView(){
        spinner.isHidden = true;
        username.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor : UIColor.purple])
        password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.purple])
    }
 

}
