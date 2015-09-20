//
//  APIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation
import OAuthSwift

class YelpAPIController:NSObject {
    let baseUrl = "http://api.yelp.com/v2/search"
    let consumerKey = "vxQLi0q-qk-KbJlmR3wyjw"
    
    let yelpOAuth = OAuthSwiftClient(
        consumerKey: config["public"]!["yelp"]!["consumer"]!,
        consumerSecret: config["private"]!["yelp"]!["consumer"]!,
        accessToken: config["public"]!["yelp"]!["token"]!,
        accessTokenSecret: config["private"]!["yelp"]!["token"]!
    )
    
    func searchYelpFor(searchTerm: String, location: String, callback: (NSDictionary) -> Void) {
        let parameters = [
            "term": searchTerm,
            "location": location
        ]
        var restaurants: NSDictionary
        yelpOAuth.get(baseUrl, parameters: parameters,
            success: {
                data, headers in
                var restaurants: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                for business in NSArray(array: restaurants["businesses"]! as! Array)   {
                    callback(business as! NSDictionary)
                }
            }, failure: {
                data in
                println(data)
            })
    }
}