//
//  UserDefaultSetting.swift
//  LoungePass
//
//  Created by MacBook on 20/05/2019.
//  Copyright © 2019 LimSoYul. All rights reserved.
//

import Foundation

open class UserDefaultSetting {
    
    func setIsAuto(value:Bool){
        UserDefaults.standard.set(value,forKey: "autoLogin")
        UserDefaults.standard.synchronize()
    }
    
    func setUserInfo(user:UserInfo)  {
        UserDefaults.standard.set(user.id, forKey: "id")
        UserDefaults.standard.set(user.pw, forKey: "pwd")
        UserDefaults.standard.set(user.tag, forKey: "tag")
        UserDefaults.standard.synchronize()
    }
    
    func removeInfo() {
        UserDefaults.standard.removeObject(forKey: "autoLogin")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pwd")
        UserDefaults.standard.removeObject(forKey: "tag")
        UserDefaults.standard.removeObject(forKey: "brightness")
        UserDefaults.standard.synchronize()
    }
    
    func setBrightness(brightness:Float){
        UserDefaults.standard.set(brightness, forKey: "brightness")
    }
    func getInfo(key:String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
}
