//
//  MYRequestController.swift
//  Apps Process
//
//  Created by Steven Hertz on 3/8/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import Foundation

enum Literals{
    static var profileKiosk: String  = { return "Profile-App-1Kiosk" }()
}

class MyRequestController {
    var apps = [App]()
    var kioskProfiles = [Profile]()
    
    func sendRequestProfiles() {
        let sessionConfig = URLSessionConfiguration.default

        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        /* Create the Request:
           get List of Profiles (GET https://api.zuludesk.com/profiles)
         */

        guard var URL = URL(string: "https://api.zuludesk.com/profiles") else {return}
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
            
            do { let profileStore = try jsonDecoder.decode(ProfileStore.self, from: data)
                self.kioskProfiles = profileStore.profiles.filter { $0.name.starts(with: Literals.profileKiosk) }
                for profile in self.kioskProfiles {
                    print(profile.name)
                }
                self.sendRequest()
            }
            catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }

    
    func sendRequest() {
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
                
                self.kioskProfiles.forEach { (profile) in
                    let appName = profile.name.replacingOccurrences(of: "Profile-App-1Kiosk ", with: "")
                    if let ap = appStore.apps.first(where: { $0.name == appName }) {
                        print(ap.name)
                    } else {
                        print(String(repeating: "- - -", count: 5), "Not Found \(appName)")
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
}



