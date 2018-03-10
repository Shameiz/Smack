//
//  ProfileVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-09.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //outlets
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = UserDataService.instance.name;
        email.text = UserDataService.instance.email;
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser();
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
