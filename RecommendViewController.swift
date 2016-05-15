//
//  RecommendViewController.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/14/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

import UIKit
import SHUtil

class RecommendViewController: UIViewController{
    @IBOutlet weak var slider: SHSliderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.slider.front.image = UIImage(named: "5star")

        
        
    }
   
}