//
//  BaseViewController.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK:- Variables
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.style = .large
        ai.center = view.center
        ai.color = .red
        ai.startAnimating()
        return ai
    }()
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- Actions
    
    func showActivityIndicator() {
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func showAlert(title: String, msg: String, otherActions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.view.tintColor = .black
        if otherActions != nil {
            otherActions?.forEach { alert.addAction($0) }
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    

}
