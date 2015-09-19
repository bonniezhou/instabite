//
//  APIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation
import OAuthSwift

protocol YelpAPIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class YelpAPIController {
    var delegate: YelpAPIControllerProtocol?
    let baseUrl = "http://api.yelp.com/v2/search"
    let consumerKey = "vxQLi0q-qk-KbJlmR3wyjw"
    
    let yelpOAuth = OAuthSwiftClient(consumerKey: config["public"]!["yelp"]!["consumer"]!, consumerSecret: config["private"]!["yelp"]!["consumer"]!, accessToken: config["public"]!["yelp"]!["token"]!, accessTokenSecret: config["private"]!["yelp"]!["token"]!)
    
    func searchYelpFor(searchTerm: String) {
        let parameters = [
            "term": searchTerm,
            "location": "Berkeley"
        ]
        yelpOAuth.get(baseUrl, parameters: parameters,
            success: {
                _, data in
                println(data)
            }, failure: {
                data in
                println(data)
            })
    }
}