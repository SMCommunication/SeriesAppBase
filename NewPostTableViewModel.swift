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
    
    let items = ObservableArray<Note>()
    
    func request(){
        let url = "https://qiita.com/api/v2/items"
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for (_, subJson) in json {
                        let feed = Note(title: subJson["title"].string,
                            username: subJson["user"]["id"].string,
                            userImageURL: subJson["user"]["profile_image_url"].string,
                            url: subJson["url"].string
                        )
                        self.items.append(feed)
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}
