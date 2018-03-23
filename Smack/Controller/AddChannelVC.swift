//
//  AddChannelVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-19.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var name: UITextField!
 
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var channelDesc: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func setupview(){
        let closetouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgview.addGestureRecognizer(closetouch)
    }
    
    @objc func closeTap(_ recognizer:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
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
