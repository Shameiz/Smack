//
//  MessageCell.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-28.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    //IBOutlets and actions
    @IBOutlet weak var imgLbl: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    //override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //class functions
    
    func configureCell(message:Message){
        self.message.text=message.message;
        self.name.text=message.username;
        self.imgLbl.image=UIImage(named: message.userAvatar)
        
        guard var isoDate=message.timestamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate=isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate=isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter=DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate=chatDate{
            let finalDate=newFormatter.string(from: finalDate)
            self.time.text=finalDate;
        }
    }

}
