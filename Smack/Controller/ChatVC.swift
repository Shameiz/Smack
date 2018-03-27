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
    
    
    @IBOutlet weak var msgTxtBox: UITextField!
    
    @IBOutlet weak var hamburger: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
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
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func updateWithChannel(){
        let channel = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelName.text = "#\(channel)";
        self.getMessages()
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if(success){
                if(MessageService.instance.channels.count>0){
                    MessageService.instance.selectedChannel=MessageService.instance.channels[0]
                    self.updateWithChannel()
                }
                else{
                    self.channelName.text="No Channels Yet"
                }
            }
        }
    }
    
  
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else{return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
    }
    
    @IBAction func sendMsgPressed(_ sender: Any) {
        if(AuthService.instance.isLoggedIn){
            guard let channelId = MessageService.instance.selectedChannel?.id else{return}
            guard let msg = msgTxtBox.text else{return}
            SocketService.instance.addMessage(messageBody: msg, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if(success){
                    self.msgTxtBox.text=""
                    self.msgTxtBox.resignFirstResponder()
                }
            })
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
