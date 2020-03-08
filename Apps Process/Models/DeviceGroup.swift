//
//  DeviceGroup.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation
struct DeviceGroup: Codable {
    
      public let id: Int
//      public let locationId: Int
      public let name: String
      public let description: String
//      public let information: String
//      public let members: Int
//      public let type: String
//      public let shared: Bool
//      public let imageUrl: URL?
//      public let isSmartGroup: Bool
    
}
extension DeviceGroup: Equatable {
  static func == (lhs: DeviceGroup, rhs: DeviceGroup) -> Bool {
    return lhs.id == rhs.id
  }
}
extension DeviceGroup: Comparable {
    static func < (lhs: DeviceGroup, rhs: DeviceGroup) -> Bool {
        lhs.name < rhs.name
    }
}

//
//public struct Profiles: Codable {
//    public let code: Int
//    public struct DeviceGroup: Codable {
//        public let id: Int
//        public let locationId: Int
//        public let name: String
//        public let description: String
//        public let information: String
//        public let members: Int
//        public let type: String
//        public let shared: Bool
//        public let imageUrl: URL?
//        public let isSmartGroup: Bool
//    }
//    public let deviceGroups: [DeviceGroup]
//}
