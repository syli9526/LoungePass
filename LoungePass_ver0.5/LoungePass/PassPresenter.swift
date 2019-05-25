//
//  PassPresenter.swift
//  LoungePass
//
//  Created by MacBook on 22/05/2019.
//  Copyright © 2019 LimSoYul. All rights reserved.
//

import Foundation
import UIKit
class PassViewPresenter: ServerConstant,PassPresenter{
    
    private let view :PassView
    private let defaultInfo = UserDefaultSetting()
    private let dataConverter = ConvertData()
    private let imageGenerator = ImageGenerator()
    private let socket = ServerConnect.sharedInstance
    private let studentInfo = StudentInfo.sharedInstance
    
    required init(view: PassView) {
        self.view = view
    }
    
    func logoutclicked() {
        print("remove")
        defaultInfo.removeInfo()
    
        socket.closing()
    }
    
    func requestImage(key:String) ->Bool{
        if key == "qr"{
            return socket.sendData(string: dataConverter.getSeqData(seq: STATE_REQ))
        }else if key == "img" {
            return socket.sendData(string: dataConverter.getSeqData(seq: STATE_IMG))
        }
        return false
    }
    
    func getStudentInfo(key:String) -> String? {
        
        switch key {
        case "name":
            return "이름 : " + studentInfo.name!
        case "studentID":
            if studentInfo.name != nil {  return "학번 : " + studentInfo.studentID!}
        
        case "department" :
             if studentInfo.department != nil {  return "학과 : " + studentInfo.department!}
        case "college" :
            if  studentInfo.college != nil {  return  "단과대학 : " + studentInfo.college!}
        default:
            return nil
        }
        return nil
    }
    
    func IsResponse() ->[String :Any]?{
        
        var response : String?
        
        while response == nil { response = socket.readResponse()}
        
        print(type(of: response))
    
        
        var dic = dataConverter.jsonStringToDictionary(text: response!)
        print(dic)
        switch dic!["seqType"] as! String {
        case STATE_CREATE : dic!["qr"] = imageGenerator.getQRCode(from: dic!["qr"] as! String)
        case STATE_URL : dic!["img"] = imageGenerator.getUrlImage(urlString: dic!["img"] as! String)
        default: break
        }
        return dic
    }

}
