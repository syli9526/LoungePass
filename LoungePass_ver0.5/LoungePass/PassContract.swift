//
//  PassContract.swift
//  LoungePass
//
//  Created by MacBook on 22/05/2019.
//  Copyright © 2019 LimSoYul. All rights reserved.
//

import Foundation

protocol PassView {
    
    func present()
 
}
protocol PassPresenter {
    init(view :PassView)
    func logoutclicked()
    func requestImage(key:String) ->Bool
}
