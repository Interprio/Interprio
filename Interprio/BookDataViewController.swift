//
//  BookDataViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 4/26/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit
import AlamofireImage

class BookDataViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var displayUsernameText: String?
    var displayText: String?
    var displayImage: UIImage?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = displayUsernameText
        displayLabel.text = displayText
        pageImageView.image = displayImage
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
