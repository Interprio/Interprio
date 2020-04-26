//
//  BookPageViewController.swift
//  Interprio
//
//  Created by Samuel Elbaz on 4/26/20.
//  Copyright © 2020 Interprio. All rights reserved.
//

import UIKit

class BookPageViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    // Pages in collection
    let dataSource = ["Book 1","Book 2","Book3 "]
    //view controller index of pages
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        // Do any additional setup after loading the view.
    }
    //initilization logic
    func configurePageViewController(){
        //get reference to custom page view controller from the story board
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
                return
        }
        
        //Assign delegate and data source
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        //add as child view controller
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        // programatic constraints
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        //Added page controller view into the contentView UIView container
        contentView.addSubview(pageViewController.view)
        
        //views dictionary
        let views: [String: Any] = ["pageView": pageViewController.view]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))

        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else { return }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        
    }
    
    func detailViewControllerAt(index: Int) -> BookDataViewController? {
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: BookDataViewController.self)) as?
            BookDataViewController else {
                return nil
        }
        
        dataViewController.index = index
        dataViewController.displayText = dataSource[index]
        
        return dataViewController
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

extension BookPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? BookDataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? BookDataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        if currentIndex == dataSource.count {
            return nil
        }
        
        currentIndex += 1
        
        return detailViewControllerAt(index: currentIndex)
        
    }
    
}