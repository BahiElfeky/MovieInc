//
//  FavoritesVC.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/21/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import UIKit

class FavoritesVC: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholderLbl: UILabel!
    
    
    var favoriteMovies: [Movie]?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavMaovies()
    }
    

    //MARK:- Setups
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func getFavMaovies(){
        
        if let favoritesData  = Globals.App.ud.data(forKey: "favorites") {
            self.tableView.isHidden = false
            self.placeholderLbl.isHidden = true
            let favorites = try! JSONDecoder().decode([Movie].self, from: favoritesData)
            self.favoriteMovies = favorites
            self.tableView.reloadData()
        } else {
            self.tableView.isHidden = true
            self.placeholderLbl.isHidden = false
        }
    }

}


//MARK:- Tableview Delegate & Datasource

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.titleLbl.text = "title: \(favoriteMovies?[indexPath.row].title ?? String())"
        cell.releaseLbl.text = "release date: \(favoriteMovies?[indexPath.row].releaseDate ?? String())"
        cell.voteLbl.text = "votes: \(favoriteMovies?[indexPath.row].vote ?? Int())"
        if let posterPath = favoriteMovies?[indexPath.row].posterPath {
            cell.posterImageV.kf.setImage(with: URL(string: posterPath), placeholder: UIImage(named: "MissingPoster"))
        }
        return cell
    }
    
    }
    
    
    
