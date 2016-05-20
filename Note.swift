//
//  Note.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/17/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

/*
 
 let myDog = Dog().observableVariant()
 
 myDog.name.observe { newName in
 print(newName)
 }
 
 myDog.name.bindTo(nameLabel.bnd_text)
 
 realm.write {
 myDog.name.value = "Jim"
 }
 
*/

import UIKit
import Bond
import RealmSwift


class Note :Object {
    dynamic var title = ""
    dynamic var mainImage = ""
    dynamic var mainImageURL : NSURL?
}


extension Note {
    class ObservableNote {
        var title : Observable<String?>
        var mainImage : Observable<UIImage?>
        var mainImageURL : NSURL?
        
        init(note: Note) {
            title = Observable(object: note, keyPath: "title")
            mainImage = Observable(object: note, keyPath: "mainImage")
        }
        
        init(title : String?, username: String?, userImageURL : String?, url : String?){
            self.title = Observable(title)
            self.mainImage = Observable<UIImage?>(nil) // initially no image
            if userImageURL != nil {
                self.mainImageURL = NSURL(string: userImageURL!)
            }else{
                self.mainImageURL = nil
            }
            
        }
        
        
        func fetchImageIfNeeded(){
            if self.mainImage.value != nil {
                // already have photo
                return
            }
            if let mainImageURL = self.mainImageURL {
                let downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(mainImageURL) {
                    [weak self] location, response, error in
                    if let location = location {
                        if let data = NSData(contentsOfURL: location) {
                            if let image = UIImage(data: data) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    // this will automatically update photo in bonded image view
                                    self?.mainImage.value = image
                                    return
                                }
                            }
                        }
                    }
                }
                downloadTask.resume()
            }
        }

    }
    func observableVariant() -> Note.ObservableNote {
        return ObservableNote(note: self)
    }
}