//
//  MessageService.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-12.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService{
    static let instance = MessageService();
    var channels = [Channel]()
    
    func findAllChannels(completion:@escaping CompletionHandler){
        Alamofire.request(GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if(response.result.error==nil){
                guard let data = response.data else {return}
                if let json = try!JSON(data:data).array{
                    for item in json{
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: description, id: id)
                        self.channels.append(channel)
                    }
                }
                completion(true)
            }
            else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
}
