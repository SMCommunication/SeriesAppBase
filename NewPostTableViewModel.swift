//
//  NewPostTableViewModel.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/17/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

import Foundation
import Bond
import Alamofire
import SwiftyJSON

class NewPostTableViewModel : NSObject {
    
    var items = ObservableArray<Note.ObservableNote>()
    
    func request(){
        APIService.test({ (note) in
            self.items.removeAll()
            
            note.forEach({ (hoge) in
                self.items.append(hoge)
            })
            
            }) { (error, code) in
        }
    }
}
