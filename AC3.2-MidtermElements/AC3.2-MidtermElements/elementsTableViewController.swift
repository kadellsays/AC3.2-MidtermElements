//
//  elementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Kadell on 12/8/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import UIKit

class elementsTableViewController: UITableViewController {
    
    var elementContained = [Elements]()
    let apiEndPoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    let identifier = "elements Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadData()
    }
    
    func loadData() {
        APIRequestManager.manager.getData(endPoint: apiEndPoint) {(data: Data?) in
            if data != nil {
                if let allData = Elements.getData(data: data!) {
                    self.elementContained = allData
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.elementContained.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let path = elementContained[indexPath.row]
        cell.textLabel?.text = path.name
        cell.detailTextLabel?.text = path.symbol + "(" + String(path.number) + ")" + "  " + String(path.weight)
        
        APIRequestManager.manager.getData(endPoint:"https://s3.amazonaws.com/ac3.2-elements/\(path.symbol)_200.png"){(data: Data?) in
            DispatchQueue.main.async {
                
            if let imageData = data {
                    cell.imageView?.image = UIImage(data: imageData)
                    cell.imageView?.layer.cornerRadius = 22
                    cell.imageView?.layer.masksToBounds = true
                }
                    cell.setNeedsLayout()
            }
        
        }

        return cell
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = elementContained[indexPath.row]
        performSegue(withIdentifier: "detail View", sender: selected)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail View", let sendElement = sender as? Elements {
            let segueElement = segue.destination as! ViewController
            segueElement.elementData = sendElement
        }
    }
    

}
