//
//  AddChannelVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-19.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    //IBOutlets and actions
    @IBOutlet weak var name: UITextField!
 
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var channelDesc: UITextField!
    
    @IBAction func createChannel(_ sender: Any) {
        guard let channelName = name.text, name.text != "" else{return}
        guard let desc = channelDesc.text, channelDesc.text != "" else{return}
        SocketService.instance.addChannel(channelName: channelName, channelDescription: desc) { (success) in
            if(success){
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closedModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //class functions
    
    func setupview(){
        let closetouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgview.addGestureRecognizer(closetouch)
    }
    
    //objc functions
    
    @objc func closeTap(_ recognizer:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
 
}
