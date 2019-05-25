//
//  ServerConstant.swift
//  LoungePass
//
//  Created by MacBook on 20/05/2019.
//  Copyright © 2019 LimSoYul. All rights reserved.
//

import Foundation

class ServerConstant{
    
     //client -> server
    let LOGIN = "104"
    
    //server ->client
    let LOGIN_OK = "101"
    let LOGIN_ALREADY = "102"
    let LOGIN_NO_DATA = "103"
    
    //client -> server
    let STATE_REQ = "200" //qr요청
    let STATE_DEL = "201" //qr삭제
    let STATE_CREATE = "202" 
    
    //server ->client
    let STATE_IMG = "203"
    let STATE_URL = "204"
    
    //client -> server
    let LOGOUT = "500"
    
}
