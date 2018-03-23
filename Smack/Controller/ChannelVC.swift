//
//  ChannelVC.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-02-25.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        tableView.delegate=self;
        tableView.dataSource=self;
        SocketService.instance.getChannel { (success) in
            if(success){
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo();
    }
    
    @IBAction func addChannel(_ sender: Any) {
        let addch = AddChannelVC()
        addch.modalPresentationStyle = .custom
        present(addch, animated: true, completion: nil)
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
    
    @objc func userDataDidChange(_ notif: Notification){
        setUpUserInfo();
    }
    
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
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count;
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
