//
//  BookCreateViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 4/2/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit

class BookCreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var genrePickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genrePickerView.delegate = self
        self.genrePickerView.dataSource = self
        //Temporary hard coded data for genres.
        pickerData = ["Mangna", "Science Fiction", "Fantasy", "Sports", "Mystery", "Item 6"]
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
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
