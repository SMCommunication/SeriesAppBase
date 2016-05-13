//
//  RankingViewController.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/14/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

import UIKit


class RankingViewController: UIViewController {
    
}


extension RankingViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        
    }
    
}