//
//  PageCreateViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 4/2/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse
import WeScan

class PageCreateViewController: UIViewController, ImageScannerControllerDelegate, UITextFieldDelegate {
    var currentUser = PFUser.current()
    var book: PFObject!
    var pages: [PFObject]!
    var defaultImage: UIImage?
    
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultImage = cameraImageView.image

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCamera(_ sender: Any) {
        let scannerViewController = ImageScannerController()
        scannerViewController.imageScannerDelegate = self
        present(scannerViewController, animated: true)
        
    }
    
    @IBAction func onCreatePage(_ sender: Any) {
        let image = cameraImageView.image
        let caption = captionTextField.text
        let newPageNumber = pages.count + 1 // pretty sure this will be an issue if two user try to upload at exactly the same time. There is probably a push or better way to do this, or a check to make sure its safe to add the extra page.
        if(image == defaultImage || caption == ""){
            print("All fields must be filled out")
        } else {
            let page = PFObject(className: "Pages")
            page["createdBy"] = PFUser.current()
            page["caption"] = caption
            page["book"] = book
            page["pageNumber"] = newPageNumber
            
            //set image
            let imageData = (image!.pngData())
            let imageFile = PFFileObject(name: "PageImage" + String(newPageNumber) + ".png", data: imageData!)
            page["image"] = imageFile
            
            //save
            page.saveInBackground { (success, error) in
                if(success) {
                    print("Page added!")
                    //need to refresh pages
                    [self .dismiss(animated: true, completion: nil)]
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        [self .dismiss(animated: true, completion: nil)]
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
