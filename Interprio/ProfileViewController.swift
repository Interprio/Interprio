//
//  ProfileViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 4/2/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var ProfileBookCollectionView: UICollectionView!

    var books = [PFObject]()
    var numOfPosts: Int!

    
    //Object Variables
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileBookFeedLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
         
        //Retreving and assigining usernameLabel its appropriate value
        self.usernameLabel.text = PFUser.current()?.username
        
        //Setting image for collection view
        let imageFile = PFUser.current()?["profilePicture"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        self.profileImage.af_setImage(withURL: url)
        

        ProfileBookCollectionView.delegate = self
        ProfileBookCollectionView.dataSource = self
        
        let layout = ProfileBookCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 8
        layout .minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
        layout.itemSize = CGSize(width: width, height: width * 2 / 2)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        numOfPosts = 10
        loadBooks()
    }
    
    //Runs a query to retrieve books made by the current user
    func loadBooks() {
        let query = PFQuery(className: "Books")
        query.includeKeys(["coverImage, title"])
        query.limit = numOfPosts
        query.whereKey("createdBy", equalTo:PFUser.current()!)
        query.findObjectsInBackground { (books, error) in
            if (books != nil && error == nil ) {
                self.books = books!
                self.ProfileBookCollectionView.reloadData()
            }
            else {
                print("No books were retrieved")
                self.profileBookFeedLabel.text  = "No Books Have Been Uploaded"
                
            }
        }
    }
    
    //Home Button
    @IBAction func backToFeed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Collection View Setup
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileBook = books[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileBookCell", for: indexPath) as! ProfileBookCollectionViewCell
        
        print(books[indexPath.row])
        
        //Setting profile book title for collection view
        cell.bookTitleLabel.text = profileBook["title"] as? String
        
        //Setting image for collection view
        let imageFile = profileBook["coverImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.bookImage.af_setImage(withURL: url)
        
        return cell
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
