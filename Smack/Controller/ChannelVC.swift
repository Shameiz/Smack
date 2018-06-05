//
//  ChannelVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-02-25.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController{
    
    //IBActions and outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    @IBAction func addChannel(_ sender: Any) {
        if(AuthService.instance.isLoggedIn){
            let addch = AddChannelVC()
            addch.modalPresentationStyle = .custom
            present(addch, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginBtnActn(_ sender: Any) {
        if(AuthService.instance.isLoggedIn){
            let profile=ProfileVC()
            profile.modalPresentationStyle = .custom;
            present(profile, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    
    //override functions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        tableView.delegate=self;
        tableView.dataSource=self;
        SocketService.instance.getChannel { (success) in
            if(success){
                self.tableView.reloadData()
            }
        }
       
    }

    //class functions
    
    func setUpUserInfo(){
        if(AuthService.instance.isLoggedIn){
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            //userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
        else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    
    //objc functions
    
    @objc func userDataDidChange(_ notif: Notification){
        setUpUserInfo();
    }
    
    
    @objc func channelsLoaded(_ notif:Notification){
        tableView.reloadData()
    }
  

}
