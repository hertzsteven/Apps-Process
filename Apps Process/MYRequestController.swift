//
//  MYRequestController.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation
import CloudKit



enum Literals{
    static var profileKiosk: String  = { return "Profile-App-1Kiosk" }()
    static var deviceGroupKiosk: String  = { return "DG -1Kiosk" }()
    
    static var appRecordType: String  = { return "App" }()
    static var userRecordType: String  = { return "User" }()
    
    static var appID: String  = { return "id" }()
    static var appname: String  = { return "name" }()
    static var appicon: String  = { return "icon" }()
    
    
}

class MyRequestController {
   
    var dbs : CKDatabase {
        return CKContainer(identifier: "iCloud.com.dia.cloudKitExample.open").publicCloudDatabase
    }

    var apps = [App]()
    var kioskProfiles = [Profile]()
    var kioskDeviceGroups = [DeviceGroup]()
    
    func sendRequestProfiles() {

        let session: URLSession = {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            return session
        }()
 
        let request: URLRequest = {
            /// create request
            guard let URL = URL(string: "https://api.zuludesk.com/profiles") else {fatalError("Could not create the url")}
            var request = URLRequest(url: URL)
            /// modify properties
            request.httpMethod = "GET"
            /// Header
            request.addValue("Basic NTM3MjI0NjA6RVBUTlpaVEdYV1U1VEo0Vk5RUDMyWDVZSEpSVjYyMkU=", forHTTPHeaderField: "Authorization")
            request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
            request.addValue("__cfduid=d6d36b16a88dbdafd9bdc5ba8668ecd911572791940; Hash=f59c9e4a0632aed5aa32c482301cfbc0", forHTTPHeaderField: "Cookie")
            
            return request
        }()
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            /// check if it was a success
            guard let data = data,(error == nil) else { fatalError("Failed at the task getting the profiles") }

            // Success - contine
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("URL Session Task Succeeded: HTTP \(statusCode)")

            let jsonDecoder = JSONDecoder()
            
            do { let profileStore = try jsonDecoder.decode(ProfileStore.self, from: data)
                self.kioskProfiles = profileStore.profiles.filter { $0.name.starts(with: Literals.profileKiosk) }
                for profile in self.kioskProfiles {
                    print(profile.name)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }

    
    func sendRequestUsers() {
        let sessionConfig = URLSessionConfiguration.default

        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        /* Create the Request:
           get List of Profiles (GET https://api.zuludesk.com/profiles)
         */

  
        let item = URLQueryItem(name: "memberOf", value: "17,18,19,20,21,22,29")
        var queryItemsArray = [URLQueryItem]()
        queryItemsArray.append(item)
        
        var urlComp =  URLComponents(string: "https://api.zuludesk.com/users")
        urlComp?.queryItems = queryItemsArray
        guard let theurl = urlComp?.url else { fatalError("url componenets error")}

        var request = URLRequest(url: theurl)
        request.httpMethod = "GET"
        
        // Headers
        request.addValue("Basic NTM3MjI0NjA6RVBUTlpaVEdYV1U1VEo0Vk5RUDMyWDVZSEpSVjYyMkU=", forHTTPHeaderField: "Authorization")
        request.addValue("1", forHTTPHeaderField: "X-Server-Protocol-Version")
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data,  (error == nil) else  {fatalError() }
            // Success
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("URL Session Task Succeeded: HTTP \(statusCode)")
            
            let jsonDecoder = JSONDecoder()
            
            do { let userStore = try jsonDecoder.decode(UserStore.self, from: data)
                // self.kioskDeviceGroups = userStore.users.filter { $0.name.starts(with: Literals.userKiosk) }
                for user in userStore.users {
                    print(user.lastName)
                    DispatchQueue.main.async {
                        self.addUserRecord(user: user, fileURL: nil)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }


    func sendRequestDeviceGroups() {
        
        let sessionConfig = URLSessionConfiguration.default

        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        /* Create the Request:
           get List of DeviceGroups (GET https://api.zuludesk.com/profiles)
         */

        guard let URL = URL(string: "https://api.zuludesk.com/devices/groups") else {return}
         var request = URLRequest(url: URL)
         request.httpMethod = "GET"

         // Headers

         request.addValue("Basic NTM3MjI0NjA6RVBUTlpaVEdYV1U1VEo0Vk5RUDMyWDVZSEpSVjYyMkU=", forHTTPHeaderField: "Authorization")
         request.addValue("2", forHTTPHeaderField: "X-Server-Protocol-Version")
         request.addValue("__cfduid=d6d36b16a88dbdafd9bdc5ba8668ecd911572791940; Hash=f59c9e4a0632aed5aa32c482301cfbc0", forHTTPHeaderField: "Cookie")

        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data,  (error == nil) else  {fatalError() }
            // Success
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("URL Session Task Succeeded: HTTP \(statusCode)")

            let jsonDecoder = JSONDecoder()
            
            do { let deviceGroupStore = try jsonDecoder.decode(DeviceGroupStore.self, from: data)
                self.kioskDeviceGroups = deviceGroupStore.deviceGroups.filter { $0.name.starts(with: Literals.deviceGroupKiosk) }
                for deviceGroup in self.kioskDeviceGroups {
                    print(deviceGroup.name)
                }
                 self.getAppsToSaveTheirIcons()
            }
            catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }

    
    func getAppsToSaveTheirIcons() {
        /* Configure session, choose between:
         * defaultSessionConfiguration
         * ephemeralSessionConfiguration
         * backgroundSessionConfigurationWithIdentifier:
         And set session-wide properties, such as: HTTPAdditionalHeaders,
         HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
         */
        let sessionConfig = URLSessionConfiguration.default
        
        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
         Get Apps List (GET https://api.zuludesk.com/apps)
         */
        
        guard var URL = URL(string: "https://api.zuludesk.com/apps") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        // Headers
        
        request.addValue("Basic NTM3MjI0NjA6RVBUTlpaVEdYV1U1VEo0Vk5RUDMyWDVZSEpSVjYyMkU=", forHTTPHeaderField: "Authorization")
        request.addValue("__cfduid=d6d36b16a88dbdafd9bdc5ba8668ecd911572791940; Hash=f59c9e4a0632aed5aa32c482301cfbc0", forHTTPHeaderField: "Cookie")
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data,  (error == nil) else  {fatalError() }
            // Success
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("URL Session Task Succeeded: HTTP \(statusCode)")
            
            let jsonDecoder = JSONDecoder()
            
            do { let appStore = try jsonDecoder.decode(AppStore.self, from: data)
                for app in appStore.apps {
                    print(app.name)
                }
                
                print(String(repeating: "- - -", count: 30))
                
                self.kioskDeviceGroups.forEach { (deviceGroup) in
                    let appName = deviceGroup.name.replacingOccurrences(of: Literals.deviceGroupKiosk + " ", with: "")
                    
                    if let ap = appStore.apps.first(where: { $0.name == appName }) {
                        print(ap.name)
                        DispatchQueue.main.async {
                            self.getTheImage(with: ap.icon, appName: appName, appid: String(deviceGroup.id))
                        }
                    } else {
                        print(String(repeating: "- - -", count: 5), "Not Found \(appName)")
                        if let apx = appStore.apps.first(where: { $0.name == deviceGroup.description }) {
                            DispatchQueue.main.async {
                                self.getTheImage(with: apx.icon, appName: appName, appid: String(deviceGroup.id))
                            }
                            print(apx.name, " We found it")
                        }
                        
                    }
                }
             }
            catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }


    func getTheImage(with url: URL, appName: String, appid: String)  {
        print(url.lastPathComponent)
        let sessionConfig = URLSessionConfiguration.default
        
        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
         Get Apps List (GET https://api.zuludesk.com/apps)
         */
        
        // guard var URL = URL(string: "https://api.zuludesk.com/apps") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data,  (error == nil) else  {fatalError() }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("Got picture: HTTP \(statusCode)")
            print(data)
            
            let filename = self.getDocumentsDirectory().appendingPathComponent(appName + ".png")
            

            do {
                try data.write(to: filename)
                DispatchQueue.main.async {
                    self.addAppRecord(id: appid, name: appName, fileURL: filename)
                }
            } catch {
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
                print(error.localizedDescription)
            }
            
        })

        task.resume()
        session.finishTasksAndInvalidate()

    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
    
    
    fileprivate func addAppRecord(id: String, name: String, fileURL: URL?) {

        /// make a record
        let recordID = CKRecord.ID(recordName: name)
        let record = CKRecord(recordType:  Literals.appRecordType, recordID: recordID)
        
        /// populate the fields
        record[Literals.appID] = NSString(utf8String: id)
        record[Literals.appname] =  NSString(utf8String: name)
        if let fileURL = fileURL  {
            let asset = CKAsset(fileURL: fileURL)
            record[Literals.appicon] = asset
        }
                
        dbs.save(record) { (record, error) in
            guard let record = record, error == nil else {print(error?.localizedDescription as Any); return}

            print("added succesfully")
            print(record as Any)
        }
    }
    fileprivate func addUserRecord(user: User, fileURL: URL?) {
        
        /// make a record
        let recordID = CKRecord.ID(recordName: user.username)
        let record = CKRecord(recordType:  Literals.userRecordType, recordID: recordID)
        
        /// populate the fields
        record["id"] = NSNumber(value: user.id)
        record["locationId"] = NSNumber(value: user.locationId)
        record["email"] = NSString(utf8String: user.email)
        record["username"] = NSString(utf8String: user.username)
        record["firstName"] = NSString(utf8String: user.firstName)
        record["lastName"] = NSString(utf8String: user.lastName)
        
        var groupIds = [NSNumber]()
        for theItem in user.groupIds {
            groupIds.append(NSNumber(value: theItem))
        }
        
        record["groupIds"] =  groupIds

//        if let fileURL = fileURL  {
//            let asset = CKAsset(fileURL: fileURL)
//            record[Literals.appicon] = asset
//        }
//
        dbs.save(record) { (record, error) in
            guard let record = record, error == nil else {print(error?.localizedDescription as Any); return}
            
            print("added succesfully")
            print(record as Any)
        }
    }

}



