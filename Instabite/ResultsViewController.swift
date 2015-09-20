//
//  ViewController.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import UIKit

class PhotosLoader: InstagramDelegate   {
    var photos: NSMutableArray = []
    func instagramPhotoFound(results: ResultsViewController, photo: NSDictionary) {
        photos.addObject([photo] as NSArray)
    }
    func instagramIsDone(results: ResultsViewController) {
        results.photos = photos
        print("done")
    }
}

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var appTableView: UITableView!
    var delegate = PhotosLoader()
    var photos: NSMutableArray = []
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Results"
//        
//        appTableView.dataSource = self
//        appTableView.delegate = self
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.photos.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ResultCell = ResultCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ResultCell")
        print(delegate.photos)
        cell.configure(text: delegate.photos[indexPath.row]["name"]!! as? String)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500
    }
}
