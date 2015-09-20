//
//  APIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation
import BrightFutures
import OAuthSwift


protocol YelpDelegate {
    func done(photos: NSMutableArray)
}

class YelpAPIController:NSObject {
    let baseUrl = "https://api.yelp.com/v2/search"
    let consumerKey = "vxQLi0q-qk-KbJlmR3wyjw"
    
    let yelpOAuth = OAuthSwiftClient(
        consumerKey: config["public"]!["yelp"]!["consumer"]!,
        consumerSecret: config["private"]!["yelp"]!["consumer"]!,
        accessToken: config["public"]!["yelp"]!["token"]!,
        accessTokenSecret: config["private"]!["yelp"]!["token"]!
    )
    var delegate: YelpDelegate?
    
    func searchYelpFor(searchTerm: String, location: String, callback: (NSDictionary) -> NSDictionary) {
        let parameters = [
            "term": searchTerm,
            "location": location
        ]
        var restaurants: NSDictionary = Dictionary<String, String>()
        yelpOAuth.get(baseUrl, parameters: parameters,
            success: {
                data, headers in
                do{
                    var allPhotos: NSMutableArray = []
                    restaurants = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
                    let businesses = restaurants["businesses"]! as! NSArray
                    for r in businesses   {
                        let restaurant = r as! NSDictionary
                        let photos = callback(restaurant)
                        allPhotos.addObject(photos)
                    }
                    self.delegate?.done(allPhotos)
                }
                catch {
                    print("fuck")
                }
            }, failure: {
                data in
                print("fuck")
            })
    }
}