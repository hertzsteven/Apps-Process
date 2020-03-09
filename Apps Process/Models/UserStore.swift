//
//  UserStore.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation

public struct UserStore: Codable {
    public let code: Int = 0
    public let count: Int = 0
    var users = [User]()
}
