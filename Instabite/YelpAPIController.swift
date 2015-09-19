//
//  APIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation
import Alamofire

protocol YelpAPIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class YelpAPIController {
    var delegate: YelpAPIControllerProtocol?
    let baseUrl = "http://api.yelp.com/v2/search"
    let consumerKey = "vxQLi0q-qk-KbJlmR3wyjw"
    func searchYelpFor(searchTerm: String) {
        let parameters = [
            "term": searchTerm,
            "oauth_consumer_key": consumerKey
        ]
        Alamofire.request(.GET, baseUrl, parameters: parameters)
            .responseJSON { request, response, JSON, error in
                println(JSON)
        }
    }
}