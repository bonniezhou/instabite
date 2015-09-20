//
//  InstagramAPIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation
import OAuthSwift

class InstagramAPIController {
    let baseUrl = "https://api.instagram.com/v1/locations"
    let instagramOAuth = OAuthSwiftClient(
        consumerKey:    config["public"]!["instagram"]!["client_id"]!,
        consumerSecret: config["private"]!["instagram"]!["client_secret"]!,
        accessToken: config["private"]!["instagram"]!["token"]!,
        accessTokenSecret: config["private"]!["instagram"]!["token"]!
    )
    
    func searchRestaurantPhotos(latitude: String, longitude: String) {
        let locationSearchPath = "/search"
        let locationSearchParameters = [
            "lat": latitude,
            "lng": longitude
        ]
        instagramOAuth.get(baseUrl + locationSearchPath, parameters: locationSearchParameters,
            success: {
                _, data in
                println(data)
                let location_id = data[0]["id"]
                let mediaSearchPath = "\(location_id)/media/recent"
                instagramOAuth.get(baseUrl + mediaSearchPath, parameters: nil,
                    success: {
                        _, data in
                        println(data)
                    }, failure: {
                        data in
                        println(data)
                })
            }, failure: {
                data in
                println(data)
        })
    }
}