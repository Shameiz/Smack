//
//  ChatVCExtension.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-06-04.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import Foundation
import UIKit

extension ChatVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell=tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell{
            let message=MessageService.instance.messages[indexPath.row];
            cell.configureCell(message: message)
            return cell;
        }
        else{
            return UITableViewCell();
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count;
    }
}
