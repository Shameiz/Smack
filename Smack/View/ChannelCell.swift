//
//  ChannelCell.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-14.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    
    //IBOutlets and functions
    @IBOutlet weak var channelLabel: UILabel!
    
    //override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }
        else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    //class functions
    
    func configureCell(channel:Channel){
        let title = channel.channelTitle ?? ""
        channelLabel.text="#\(title)";
        
    }
        
}


