//
//  ChatVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-02-25.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //IBOUTLETS and outlets
    @IBOutlet weak var channelName: UILabel!
    
    
    @IBOutlet weak var msgTxtBox: UITextField!
    
    @IBOutlet weak var hamburger: UIButton!
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
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
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if(msgTxtBox.text==""){
            isTyping=false;
            sendBtn.isHidden=true;
        }else{
            sendBtn.isHidden=false;
            isTyping=true;
        }
    }
    
    //VARS
    var isTyping = false;
    
    //override functions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.estimatedRowHeight=80;
        tableView.rowHeight=UITableViewAutomaticDimension;
        sendBtn.isHidden=true;
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
        else{
            channelName.text="Please Log In";
        }
        SocketService.instance.getChatMessage { (success) in
            if(success){
                self.tableView.reloadData()
                if (MessageService.instance.messages.count > 0){
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
    }
    
    //class functions
    
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
            if(success){
                self.tableView.reloadData()
            }
        }
    }
    
    //objc functions
    
    @objc func userDataDidChange(_ notif: Notification){
        if(AuthService.instance.isLoggedIn){
            onLoginGetMessages()
        }
        else{
            channelName.text="Please Log In";
            self.tableView.reloadData()
        }
        
    }
    
    @objc func channelSelected(_ notif:Notification){
        updateWithChannel()
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
}
