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

    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCollectionViewCell
//        cell.backgroundColor = UIColor.cyan
        cell.bookCellImage.image = UIImage(named: "interprio_logo")
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
