//
//  InstagramAPIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation
import OAuthSwift

protocol InstagramDelegate {
    func instagramPhotoFound(photo: NSDictionary)
    func instagramIsDone()
}

class InstagramAPIController {
    let baseUrl = "https://api.instagram.com/v1/locations"
    let instagramOAuth = OAuthSwiftClient(
        consumerKey:    config["public"]!["instagram"]!["clientId"]!,
        consumerSecret: config["private"]!["instagram"]!["clientSecret"]!,
        accessToken: config["private"]!["instagram"]!["token"]!,
        accessTokenSecret: config["private"]!["instagram"]!["token"]!
    )
    var delegate: InstagramDelegate?
    
    func searchRestaurantPhotos(restaurant: NSDictionary) {
        print(restaurant)
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
                    print(results["data"]!)
                    let matchingIndex = self.searchByName(restaurant, insta: results["data"]! as! Array<NSDictionary>)
                    print(matchingIndex)
                    if(matchingIndex != -1){
                        let id = (results["data"]![matchingIndex]["id"]! as! NSString).floatValue
                        self.getRestaurantPhotos(Int(id), name: results["data"]![matchingIndex]["name"]! as! String)
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
    
    func searchByName(yelp: NSDictionary, insta: Array<NSDictionary>) -> Int  {
        for i in 0...insta.count - 1  {
            if (yelp["name"]! === insta[i]["name"]!)  {
                return i
            }
        }
        return -1
    }
    
    func getRestaurantPhotos(id: Int, name: String) {
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
                    print("fuck")
                    if(results["data"]!.count > 0){
                        let photos = [
                            "name": name,
                            "photos": results["data"]!
                        ] as NSDictionary
                        self.delegate?.instagramPhotoFound(photos)
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