//
//  Student.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation
struct User: Codable {
    
    public let id: Int
//    public let locationId: Int
//    public let status: String
//    public let deviceCount: Int
    public let email: String
    public let username: String
//    public let domain: String
    public let firstName: String
    public let lastName: String
//    public let groupIds: [Int]
//    public let groups: [String]
//    public let teacherGroups: [Any] //TODO: Specify the type to conforms Codable protocol
//    public let children: [Any] //TODO: Specify the type to conforms Codable protocol
//    public let vpp: [Any] //TODO: Specify the type to conforms Codable protocol
//    public let notes: String
//    public let exclude: Bool
//    public let modified: String
    
}
extension User: Equatable {
  static func == (lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username
  }
}
extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.username < rhs.username
    }
}


