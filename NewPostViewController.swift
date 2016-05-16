//
//  NewPostViewController.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/14/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

import UIKit
import Bond

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let noteViewModel = NewPostTableViewModel()
    var dataSource = ObservableArray<ObservableArray<Note>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ObservableArray([noteViewModel.items])
        
        dataSource.bindTo(tableView) { indexPath, dataSource, tableView in
            guard let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? NewPostTableViewCell else { return UITableViewCell() }
            let note:Note = dataSource[indexPath.section][indexPath.row]
            note.title
                .bindTo(cell.title.bnd_text)
                .disposeIn(cell.bnd_bag)
            note.mainImage
                .bindTo(cell.userImageView.bnd_image)
                .disposeIn(cell.bnd_bag)
            
            note.fetchImageIfNeeded()
            return cell
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.noteViewModel.request()
    }
    
}

extension NewPostViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("afdafa")
    }
}