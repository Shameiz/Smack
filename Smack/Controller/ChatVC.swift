//
//  ChatVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-02-25.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //IBOUTLETS
    @IBOutlet weak var channelName: UILabel!
    
    
    
    @IBOutlet weak var hamburger: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hamburger.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        if(AuthService.instance.isLoggedIn){
            AuthService.instance.findByUserEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if(AuthService.instance.isLoggedIn){
            onLoginGetMessages()
        }
        else{
            channelName.text="Please Log In";
        }
        
    }
    
    @objc func channelSelected(_ notif:Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channel = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelName.text = "#\(channel)";
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if(success){
                //do stuff with channels
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
