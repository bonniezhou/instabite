//
//  InstagramAPIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation
import OAuthSwift

//protocol InstagramDelegate {
//    func instagramPhotoFound(photo: NSDictionary)
//}

class InstagramAPIController {
    let baseUrl = "https://api.instagram.com/v1/locations"
    let instagramOAuth = OAuthSwiftClient(
        consumerKey:    config["public"]!["instagram"]!["clientId"]!,
        consumerSecret: config["private"]!["instagram"]!["clientSecret"]!,
        accessToken: config["private"]!["instagram"]!["token"]!,
        accessTokenSecret: config["private"]!["instagram"]!["token"]!
    )
//    var delegate: InstagramDelegate?
    
    func searchRestaurantPhotos(restaurant: NSDictionary) -> NSDictionary {
            let latitude: Float = restaurant["location"]!["coordinate"]!!["latitude"]! as! Float
            let longitude: Float = restaurant["location"]!["coordinate"]!!["longitude"]! as! Float
            let locationSearchPath = "/search"
            let locationSearchParameters = [
                "client_id": config["public"]!["instagram"]!["clientId"]!,
                "lat": latitude,
                "lng": longitude,
                "access_token": config["private"]!["instagram"]!["token"]!,
            ]
            instagramOAuth.get(baseUrl + locationSearchPath, parameters: locationSearchParameters as! Dictionary,
                success: {
                    response, headers in
                    do  {
                        let results: NSDictionary = try NSJSONSerialization.JSONObjectWithData(response, options: []) as! NSDictionary
                        let matchingIndex = self.searchByName(restaurant, insta: results["data"]! as! Array<NSDictionary>)
                        if(matchingIndex != -1){
                            let id = (results["data"]![matchingIndex]["id"]! as! NSString).floatValue
                            return self.getRestaurantPhotos(Int(id), name: results["data"]![matchingIndex]["name"]! as! String)
                        }
                    }
                    catch {
                        print("fuck")
                    }
                }, failure: {
                    data in
                    print("fuck")
                })
    }
    
    func searchByName(yelp: NSDictionary, insta: Array<NSDictionary>) -> Int  {
        for i in 0...insta.count - 1  {
            if (yelp["name"]! as! String == insta[i]["name"]! as! String)  {
                return i
            }
        }
        return -1
    }
    
    func getRestaurantPhotos(id: Int, name: String) -> NSDictionary {
        let mediaSearchPath = "/\(id)/media/recent"
        let mediaSearchParameters = [
            "client_id": config["public"]!["instagram"]!["clientId"]!,
            "access_token": config["private"]!["instagram"]!["token"]!,
        ]
        instagramOAuth.get(baseUrl + mediaSearchPath, parameters: mediaSearchParameters,
            success: {
                response, headers in
                do  {
                    let results: NSDictionary = try NSJSONSerialization.JSONObjectWithData(response, options: []) as! NSDictionary
                    if(results["data"]!.count > 0){
                        let photos = [
                            "name": name,
                            "photos": results["data"]!
                        ] as NSDictionary
                        return photos
                    }
                }
                catch {
                    print("fuck")
                }
            }, failure: {
                data in
                print(data)
            })
    }
}