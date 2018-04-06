//
//  MessageCell.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-28.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var imgLbl: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message:Message){
        self.message.text=message.message;
        self.name.text=message.username;
        self.time.text=message.timestamp;
        self.imgLbl.image=UIImage(named: message.userAvatar)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
