//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-01.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //Outlets
    @IBOutlet weak var avatarPic: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backgroundPressed(_ sender: Any) {
    }
    @IBAction func chooseAvatarPress(_ sender: Any) {
    }
    @IBAction func createAccPressed(_ sender: Any) {
        guard let name = usernameText.text, usernameText.text != "" else{return}
        guard let email = emailText.text, emailText.text != "" else{return}
        guard let pass = passwordText.text, passwordText.text != "" else{return}
        AuthService.instance.registerUser(email: email, password: pass){
            (success) in
            if(success){
                AuthService.instance.loginUser(email: email, password: pass){
                    (success) in
                    if(success){
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if(success){
                                print(UserDataService.instance.name,UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                }
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissAccountPage(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
