//
//  SocketService.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-22.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    let socket = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    func establishConnection(){
        socket.defaultSocket.connect()
    }
    
    func closeConnection(){
        socket.defaultSocket.disconnect()
    }
    
    func addChannel(channelName:String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.defaultSocket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else{return}
            guard let channelDesc = dataArray[1] as? String else{return}
            guard let channelId = dataArray[2] as? String else{return}
            
            let newChannel = Channel(channelTitle: channelName,channelDescription: channelDesc,id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId:String, completion:@escaping CompletionHandler) {
        let user = UserDataService.instance;
        socket.defaultSocket.emit("newMessage", messageBody,userId,channelId,user.name,user.avatarName,user.avatarColor);
        completion(true);
        
    }
 
}
