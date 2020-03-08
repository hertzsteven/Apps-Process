//
//  ProfileStore.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation

struct ProfileStore: Codable {
    
    var profiles = [Profile]()

}

//public struct Profiles: Codable {
//    public struct Profile: Codable {
//        public let id: Int
//        public let locationId: Int
//        public struct `Type`: Codable {
//            public let value: String
//        }
//        public let type: Type
//        public struct Status: Codable {
//            public let value: String
//        }
//        public let status: Status
//        public let identifier: String
//        public let name: String
//        public let description: String
//        public let platform: String
//        public let removalPolicy: Int
//        public let removalPassword: String
//        public let daysOfTheWeek: [Any] //TODO: Specify the type to conforms Codable protocol
//        public let isTemplate: Bool
//        public let startTime: Any? //TODO: Specify the type to conforms Codable protocol
//        public let endTime: Any? //TODO: Specify the type to conforms Codable protocol
//        public let useHolidays: Bool
//        public let restrictedWeekendUse: Bool
//    }
//    public let profiles: [Profile]
//}
