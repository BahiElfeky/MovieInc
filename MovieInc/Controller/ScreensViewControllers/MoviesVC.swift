//
//  MoviesVC.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesVC: BaseViewController {
    
    var movies: [Movie]?

    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getNowPlayingMovies()
    }
    

    //MARK:- Setups
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    
    //MARK:- Services

    func getNowPlayingMovies(){
        self.showActivityIndicator()
        
        MovieServices.sharedInstanace.getNowPlaying(onSuccess: { [weak self] (list) in
            guard let weakSelf = self else {return}
            
            weakSelf.removeActivityIndicator()
            weakSelf.movies = list.movies
            weakSelf.tableView.reloadData()
            
        }) { [weak self] (error) in
            guard let weakSelf = self else {return}
            weakSelf.removeActivityIndicator()
            weakSelf.showAlert(title: error.domain, msg: "Somthing wrong happend with the request")
        }
    }

}


//MARK:- Tableview Delegate & Datasource

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:  return movies?.count ?? 0
        case 1:  return 5
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.titleLbl.text = "title: \(movies?[indexPath.row].title ?? String())"
        cell.releaseLbl.text = "release date: \(movies?[indexPath.row].releaseDate ?? String())"
        cell.voteLbl.text = "votes: \(movies?[indexPath.row].vote ?? Int())"
        if let posterPath = movies?[indexPath.row].posterPath {
            cell.posterImageV.kf.setImage(with: URL(string: posterPath), placeholder: UIImage(named: "MissingPoster"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVc = storyboard!.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        switch indexPath.section {
        case 0:
            detailVc.movieId = self.movies?[indexPath.row].id
        case 1:
            ()
        default:
            ()
        }
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Now play"
        case 1: return "Recommended"
        default: return ""
        }
    }
    
    
    
}
