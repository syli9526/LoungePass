//
//  MainContract.swift
//  LoungePass
//
//  Created by MacBook on 20/05/2019.
//  Copyright © 2019 LimSoYul. All rights reserved.
//

import Foundation

protocol View {
    func showAlert(Message: String)
    func present()
    
}
protocol Presenter {
    init(view :View)
    func isPlayAutoLogin(brightness: Float) ->Bool
    func loginClicked(user : UserInfo, brightness: Float)->String
    func autoLoginClicked(isAuto :Bool)
    func setNewIP(newIP :String)
}
