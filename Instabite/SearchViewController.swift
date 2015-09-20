//
//  SearchViewController.swift
//  Instabite
//
//  Created by Joy Gao on 2015-09-19.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import UIKit

class PhotosLoader: InstagramDelegate   {
    var photos: NSMutableArray = []
    func instagramPhotoFound(photo: NSDictionary) {
        photos.addObject([photo] as NSArray)
    }
    func instagramIsDone() {
        print("done")
    }
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var foodTypeInput: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBAction func getSearchResults(sender: UIButton){
        let Yelp: YelpAPIController = YelpAPIController()
        let Instagram = InstagramAPIController()
        Yelp.searchYelpFor(foodTypeInput.text!, location: "Waterloo", callback:
            Instagram.searchRestaurantPhotos
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var yelp = YelpAPIController()
        var instagram = InstagramAPIController()
        instagram.searchRestaurantPhotos("37.786138600000001", longitude: "-122.40262130000001")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
