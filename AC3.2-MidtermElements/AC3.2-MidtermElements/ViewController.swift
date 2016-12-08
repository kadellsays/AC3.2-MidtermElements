//
//  ViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Kadell on 12/8/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let postEndPoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    var elementData: Elements?
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = elementData!.name
       setUp()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUp() {
        if let number = elementData?.number, let name = elementData?.name, let weight = elementData?.weight, let boiling = elementData?.boiling, let melting = elementData?.melting  {
            numberLabel.text = String(describing: number)
            nameLabel.text = name
            weightLabel.text = String(weight)
            if boiling == 0.0 || melting == 0.0 {
                meltingLabel.text = "Unkown Melting Point"
                boilingLabel.text = "Unkown Boiling Point"
            } else {
            meltingLabel.text = String("Melting Point: \(melting)")
            boilingLabel.text = String("Boiling Point: \(boiling)")
            }
        }
        
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(elementData!.symbol).png"){ (data:Data?) in
            DispatchQueue.main.async {
                
                if let imageData = data {
                    self.elementImage.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        APIRequestManager.manager.postRequest(endPoint: postEndPoint, data: ["my_name": "Kadell Gregory", "favorite_element": "\(elementData!.name)"])
        print("Info Posted")
    }

}

