//
//  BookCreateViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 4/2/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit
import WeScan
import AlamofireImage
import Parse

class BookCreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ImageScannerControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var genrePickerView: UIPickerView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var cameraImageView: UIImageView!
    var defaultImage: UIImage?
    var pickerData: [String] = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitleTextField.delegate = self
        captionTextField.delegate = self
        self.genrePickerView.delegate = self
        self.genrePickerView.dataSource = self
        //Temporary hard coded data for genres.
        defaultImage = cameraImageView.image
        pickerData = ["Select Genre", "Manga", "Science Fiction", "Fantasy", "Sports", "Mystery", "Other"]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let scannerViewController = ImageScannerController()
        scannerViewController.imageScannerDelegate = self
        present(scannerViewController, animated: true)
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
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        // The user successfully scanned an image, which is available in the ImageScannerResults
        // You are responsible for dismissing the ImageScannerController
        let image = results.croppedScan.image as! UIImage
        let size = CGSize(width: 640, height: 480)
        let scaledImage = image.af.imageAspectScaled(toFit: size)
        cameraImageView.image = scaledImage
        scanner.dismiss(animated: true)
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // The user tapped 'Cancel' on the scanner
        // You are responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        // You are responsible for carefully handling the error
        print(error)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let image = cameraImageView.image
        let bookTitle = bookTitleTextField.text
        let caption = captionTextField.text
        let genre = pickerData[genrePickerView.selectedRow(inComponent: 0)]
        let page = 1
        print(genre)
        if(image == defaultImage || caption == "" || genre == "Select Genre" || bookTitle == "") {
            print("All fields must be filled out")
        }else{
            let book = PFObject(className: "Books")
            book["createdBy"] = PFUser.current()
            book["title"] = bookTitle
            book["genre"] = genre
            
            //set image
            let imageData = (image!.pngData())
            let imageFile = PFFileObject(name: bookTitle! + "Cover.png", data: imageData!)
            book["coverImage"] = imageFile
            
            //sign up
            book.saveInBackground { (success, error) in
                if(success) {
                    let page = PFObject(className: "Pages")
                    //set book
                    page["book"] = PFObject(withoutDataWithClassName: "Books", objectId: book.objectId)
                    //set page #
                    page["pageNumber"] = 1
                    //set art
                    page["image"] = imageFile
                    //set caption
                    page["caption"] = caption
                    //set user
                    page["createdBy"] = PFUser.current()
                    page.saveInBackground { (success, error) in
                        if(success) {
                            print("page created")
                        } else {
                            print("Error: \(error?.localizedDescription)")
                        }
                    }
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
            
        }
        
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
