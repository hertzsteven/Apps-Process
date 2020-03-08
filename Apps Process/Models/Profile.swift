//
//  Profile.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation
struct Profile: Codable {
    
      public let id: Int
    // ™public let locationId: Int
    //  public let isBook: Bool
    //  public let bundleId: String
    //  public let icon: URL
    public let name: String
    //  public let version: Date
    //  public let shortVersion: String
    //  public let extVersion: Int
    //  public let supportsiBooks: Bool
    //  public let platform: String
    //  public let type: String
    //  public let showInTeacher: Bool
    //  public let allowTeacherDistribution: Bool
    //  public let teacherGroups: [Any] //TODO: Specify the type to conforms Codable protocol
    //  public let showInParent: Bool
    //  public let mediaPriority: Int
    //  public let removeWithProfile: Bool
    //  public let disableBackup: Bool
    //  public let lastModified: String
    //  public let automaticReinstallWhenRemoved: Any? //TODO: Specify the type to conforms Codable protocol
    //  public let automaticUpdate: Any? //TODO: Specify the type to conforms Codable protocol
    //  public let adamId: Date
    public let description: String?
    //  public let externalVersion: Int
    //  public let html: String
    //  public let vendor: String
    //  public let price: Int
    //  public let isDeleted: Bool
    //  public let isDeviceAssignable: Bool
    //  public let is32BitOnly: Bool
    //  public let isCustomB2B: Bool
    //  public let deviceFamilies: [String]
    //  public let isTvOSCompatible: Bool
    
}
extension Profile: Equatable {
  static func == (lhs: Profile, rhs: Profile) -> Bool {
    return lhs.id == rhs.id
  }
}
extension Profile: Comparable {
    static func < (lhs: Profile, rhs: Profile) -> Bool {
        lhs.name < rhs.name
    }
}
