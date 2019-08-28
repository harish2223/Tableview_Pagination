//
//  ViewController.swift
//  PaginationTableview
//
//  Created by Harish on 8/28/19.
//  Copyright © 2019 harish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var list_Tableview: UITableView!
    var listDat = [Int]()
    var fetchingMore :Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        listDat = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        fetchingMore = false
        // Do any additional setup after loading the view, typically from a nib.
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
           return listDat.count
        }else if section == 1{
           return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = list_Tableview.dequeueReusableCell(withIdentifier: "listTableViewCell") as! listTableViewCell
            cell.data_Label.text = "Item \(listDat[indexPath.row])"
            return cell
        }else{
            let cell = list_Tableview.dequeueReusableCell(withIdentifier: "LoadTableViewCell") as! LoadTableViewCell
            cell.activityIndicate.startAnimating()
            return cell
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetched()
            }
    }

}
    
    func beginBatchFetched(){
        fetchingMore = true
        //list_Tableview.reloadSections(IndexSet(integer:1), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            let newItems = (self.listDat.count...self.listDat.count + 12).map { index in
                return index
            }
            self.listDat.append(contentsOf: newItems)
            self.fetchingMore = false
            self.list_Tableview.reloadData()
        })
    }
}


