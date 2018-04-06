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
    
    func getChatMessage(completion:@escaping CompletionHandler){
        socket.defaultSocket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else{return}
            guard let channelId = dataArray[2] as? String else{return}
            guard let userName = dataArray[3] as? String else{return}
            guard let userAvatar = dataArray[4] as? String else{return}
            guard let userAvatarColor = dataArray[5] as? String else{return}
            guard let messageId = dataArray[6] as? String else{return}
            guard let timestamp = dataArray[7] as? String else{return}
            
            if(channelId == MessageService.instance.selectedChannel?.id){
                let newMessage = Message(message: msgBody, username: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: messageId, timestamp: timestamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }
            else{
                completion(false)
            }
        }
    }
 
}
