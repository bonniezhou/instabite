//
//  APIController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import Foundation

protocol YelpAPIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class YelpAPIController {
    var delegate: YelpAPIControllerProtocol?
    
    func searchYelpFor(searchTerm: String) {
        //api magic
    }
}