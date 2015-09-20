//
//  ViewController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YelpDelegate {
    @IBOutlet weak var appTableView: UITableView!
    var photos: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Results"
        
        appTableView.dataSource = self
        appTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func instagramPhotoFound(photo: NSDictionary) {
//        print(photo)
//        self.photos.addObject([photo] as NSArray)
//    }
    
    func done(photos: NSMutableArray) {
        print(photos)
        self.photos = photos
//        self.appTableView!.reloadData()
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ResultCell = ResultCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ResultCell")
        
//        if let rowData: NSDictionary = self.photos[indexPath.row] as? NSDictionary
//        urlString = rowData["artworkUrl60"] as? String
//        imgURL = NSURL(string: urlString)
//        imgData = NSData(contentsOfURL: imgURL)
//        
//        cell.title?.text =
//        cell.topLeft?.image =
//        cell.topRight?.image =
//        cell.bottomLeft?.image =
//        cell.bottomRight?.image =
        
        cell.configure(text: photos[indexPath.row]["name"]!! as? String)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500
    }
}
