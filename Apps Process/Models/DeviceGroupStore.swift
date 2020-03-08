//
//  DeviceGroupStore.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation

public struct DeviceGroupStore: Codable {
    public let code: Int = 0
    var deviceGroups = [DeviceGroup]()
}
