//
//  UserInformation.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/11/06.
//

import Foundation

class UserInformation {
    /**
     해킹 공격에 취약할 수 있다.
     */
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var password: String?
}
