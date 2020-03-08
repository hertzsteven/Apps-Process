//
//  ViewController.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/7/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apps = [App]()
    var x = [1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequestController = MyRequestController()
        myRequestController.sendRequestDeviceGroups()
        
        
    }
    
    func sampleData() {
                
               [
                   App(id: 1, name: "First App", description: "This is first app"),
                   App(id: 2, name: "Second App", description: "This is Second app"),
                   App(id: 3, name: "Third App", description: "This is Third app"),
                   App(id: 4, name: "Fourth App", description: "This is Fourth app")
               ]
               .forEach { apps.append($0)}
               
               dump(apps)
               
//               guard let app = apps.first(where: { $0.name == "Second App" }) else {fatalError()}
//               print(app.description)
        
    }
    
    
}

