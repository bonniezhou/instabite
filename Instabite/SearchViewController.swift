//
//  SearchViewController.swift
//  Instabite
//
//  Created by Joy Gao on 2015-09-19.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var foodTypeInput: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBAction func getSearchResults(sender: UIButton){
        let Yelp: YelpAPIController = YelpAPIController()
        let Instagram = InstagramAPIController()
        Yelp.delegate = ResultsViewController()
        Yelp.searchYelpFor(foodTypeInput.text!, location: location.text!, callback:
            Instagram.searchRestaurantPhotos
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
