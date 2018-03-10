//
//  UserDataService.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-03-05.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    public private (set) var id = ""
    public private (set) var avatarColor = ""
    public private (set) var avatarName = ""
    public private (set) var email = ""
    public private (set) var name = ""
    
    func setUserData(id: String, color: String, avatar: String, email: String, name: String){
        self.id = id;
        self.avatarColor=color;
        self.avatarName=avatar
        self.email=email;
        self.name=name;
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName=avatarName
    }
    
    func logoutUser(){
        id=""
        avatarColor=""
        avatarName=""
        email=""
        name=""
        AuthService.instance.isLoggedIn=false
        AuthService.instance.userEmail=""
        AuthService.instance.authToken=""
    }
}
