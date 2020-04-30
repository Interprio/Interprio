//
//  FeedViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 3/30/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    
      
    @IBOutlet weak var collectionView: UICollectionView!
    var books = [PFObject]()
    var numberOfPosts: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //customize layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 8
        layout .minimumInteritemSpacing = 4
         let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
               layout.itemSize = CGSize(width: width, height: width * 2 / 2)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        numberOfPosts = 10
        loadPosts()
    }
    
    func loadPosts(){
        let query = PFQuery(className: "Books")
        query.includeKeys(["coverImage"])
        query.limit = numberOfPosts
        query.findObjectsInBackground { (books, error) in
            if (books != nil){
                self.books = books!
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
        
    }
    
    @IBAction func toProfile(_ sender: Any) {
        performSegue(withIdentifier: "profileSegue", sender: self)
        
    }
    
    
    @IBAction func onSubmitBook(_ sender: Any) {
//        performSegue(withIdentifier: "submitBookSegue", sender: self)
        print("submit book")
    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let book = books[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCollectionViewCell
        let imageFile = book["coverImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        print(url)
        cell.bookCellImage.af.setImage(withURL: url)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueBook"){
        //Grab selected book
        let cell = sender as! UICollectionViewCell
        
        let indexPath = collectionView.indexPath(for: cell)!
        //get all pages in book
        let book = books[indexPath.row]
            print("book", book)
        //pass the book details in segue to destination
            let navVC = segue.destination as! UINavigationController
            let bookViewController = navVC.topViewController as! BookPageViewController
        bookViewController.book = book
            do{
                try bookViewController.pages = getBookPages(book: book)
            } catch {
                print("failed to load pages")
            }
        }
    }
    
    func getBookPages(book:PFObject) throws -> [PFObject]   {
        let query = PFQuery(className: "Pages")
        query.whereKey("book", equalTo: book)
        let results = try query.findObjects()
        return results
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
