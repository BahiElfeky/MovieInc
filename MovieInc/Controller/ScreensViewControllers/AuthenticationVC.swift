//
//  AuthenticationVC.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/21/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import UIKit
import Foundation

class AuthenticationVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func authenticateTapped(_ sender: Any) {
        
        createRequestToken()
    }
    
    func createRequestToken(){
        self.showActivityIndicator()
        
        if (UserDefaults.standard.value(forKey: ServicesConstants.Keys.sessionId) == nil) {
            AuthenticationServices.sharedInstanace.createRequestToken(onSuccess: { [weak self] (response) in
                guard let weakSelf = self else {return}
                UserDefaults.standard.set(response.requestToken ?? "", forKey: ServicesConstants.Keys.requestToken)
                ServicesConstants.Values.requestToken = response.requestToken ?? ""
                weakSelf.createSession()
            }) { [weak self] (error) in
                guard let weakSelf = self else {return}
                weakSelf.removeActivityIndicator()
                weakSelf.showAlert(title: "Error", msg: error.domain)
            }
        } else {
            let moviesVC = storyboard!.instantiateViewController(withIdentifier: "MoviesVC") as! UINavigationController
            present(moviesVC, animated: true, completion: nil)
        }
    }
    
    func createSession(){
        
        AuthenticationServices.sharedInstanace.createSession(onSuccess: { [weak self] (response) in
            guard let weakSelf = self else {return}
            weakSelf.removeActivityIndicator()
            UserDefaults.standard.set(response.sessionId ?? "", forKey: ServicesConstants.Keys.sessionId)
            ServicesConstants.Values.sessionId = response.sessionId ?? ""
            let moviesVC = weakSelf.storyboard!.instantiateViewController(withIdentifier: "MoviesVC") as! UINavigationController
            weakSelf.present(moviesVC, animated: true, completion: nil)
        }) { [weak self] (error) in
            guard let weakSelf = self else {return}
            weakSelf.removeActivityIndicator()
            weakSelf.showAlert(title: "Error", msg: error.domain)
        }
        
    }
    
    
    

}
