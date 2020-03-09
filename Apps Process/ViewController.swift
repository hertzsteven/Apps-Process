//
//  ViewController.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/7/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    var dbs : CKDatabase {
          return CKContainer(identifier: "iCloud.com.dia.cloudKitExample.open").publicCloudDatabase
      }
    
    var apps = [App]()
    var x = [1,2,3,4,5]
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // addRecord()
        // getAppRecord()
        
        let myRequestController = MyRequestController()
        myRequestController.sendRequestUsers()
        
        
    }
    
    func getAppRecord()  {
        // make a ckrecordid
        let recordID = CKRecord.ID(recordName: "Butterfly Math")
        
        dbs.fetch(withRecordID: recordID) { (record, error) in
            guard let record = record, error == nil else { fatalError("could not get record") }
            
            if let asset = record["icon"] as? CKAsset {
                print(asset.fileURL?.absoluteString)
                DispatchQueue.main.async {
                    self.iconImage.image = UIImage(contentsOfFile: asset.fileURL!.path)
                }
            }
            
            
        }

        
        // do the fetch
        
    }
    fileprivate func addRecord() {
        // Do any additional setup after loading the view.
        
        // make a ckrecord
        let record = CKRecord(recordType: "iPad")
        record["currentUser"] = NSString("Mevy")
        record["identifier"] =  NSString("qqqq")
        record["userLevel"] =   NSString("qqqq")
        
        dbs.save(record) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("added succesfully")
            print(record as Any)
        }
    }

    func sampleData() {
                
//               [
//                   App(id: 1, name: "First App", description: "This is first app"),
//                   App(id: 2, name: "Second App", description: "This is Second app"),
//                   App(id: 3, name: "Third App", description: "This is Third app"),
//                   App(id: 4, name: "Fourth App", description: "This is Fourth app")
//               ]
//               .forEach { apps.append($0)}
//               
//               dump(apps)
               
//               guard let app = apps.first(where: { $0.name == "Second App" }) else {fatalError()}
//               print(app.description)
        
    }
    
    
}

