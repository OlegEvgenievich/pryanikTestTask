//
//  ObjectInfoViewController.swift
//  pryanikTest
//
//  Created by Олег Бабыр on 06.06.2021.
//

import UIKit

class ObjectInfoViewController: UIViewController {

    var objectInfoText: String!
    
    @IBOutlet var objectInfoLabel: UILabel!
    
    init?(coder: NSCoder, objectInfoText: String) {
        self.objectInfoText = objectInfoText
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectInfoLabel.text = objectInfoText
    }

}
