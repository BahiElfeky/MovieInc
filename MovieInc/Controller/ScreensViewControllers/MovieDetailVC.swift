//
//  MovieDetailVC.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import UIKit

class MovieDetailVC: BaseViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var posterImageV: UIImageView!
    @IBOutlet weak var detailsTV: UITextView!
    @IBOutlet weak var addToFavBtn: UIButton!
    @IBOutlet weak var titleLblTxt: UILabel!
    @IBOutlet weak var yearOfReleaseLbl: UILabel!
    @IBOutlet weak var overviewTV: UITextView!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables
    
    var movieId: Int?
    var movie: Movie?
    var recommendedMovies: [Movie]?
    
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getMovieDetails()
        getMovieRecommendations()
        
    }
    

    //MARK:- Setups
    
    func setupUi(movie: Movie){
        self.movie = movie
        self.detailsTV.text = movie.overview
        self.titleLblTxt.text = "Title: \(movie.title ?? "")"
        self.yearOfReleaseLbl.text = "Released: \(movie.releaseDate ?? "")"
        self.genreLbl.text = movie.genre?.count ?? 0 > 1 ? movie.genre?.reduce("") {$0 + ("\($1.name ?? String()),")} : movie.genre?[0].name
        self.ratingLbl.text = "Rate: \(movie.voteAverage ?? 0)"
        self.posterImageV.kf.setImage(with: URL(string: self.movie?.posterPath ?? ""), placeholder: UIImage(named: "MissingPoster"))
    }
    
    func setupCollectionView(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "MovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        let layout = LeftAlignedCollectionViewFlowLayout()
        let width = (collectionView.frame.size.width / 3) - 2
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    //MARK:- Services
    
    func getMovieDetails(){
        self.showActivityIndicator()
        MovieServices.sharedInstanace.getMovieDetails(movieId: self.movieId ?? Int(), onSuccess: { [weak self] (movie) in
            
            guard let weakSelf = self else {return}
            weakSelf.setupUi(movie: movie)
            
        }) { [weak self] (error) in
            guard let weakSelf = self else {return}
            weakSelf.showAlert(title: "Error", msg: error.domain)
        }
    }
    
    func getMovieRecommendations(){
        
        MovieServices.sharedInstanace.getMovieRecommendations(movieId: self.movieId ?? Int(), onSuccess: { [weak self] (moviesList) in
            
            guard let weakSelf = self else {return}
            weakSelf.recommendedMovies = moviesList.movies
            weakSelf.removeActivityIndicator()
            weakSelf.collectionView.reloadData()
            
        }) { [weak self] (error) in
            guard let weakSelf = self else {return}
            weakSelf.removeActivityIndicator()
            weakSelf.showAlert(title: "Error", msg: error.domain)
        }
    }
    
    //MARK:- Actions
    
    @IBAction func addToFavTapped(_ sender: Any) {
        if let favoritesData  = Globals.App.ud.data(forKey: "favorites"){
            
            var favorites = try! JSONDecoder().decode([Movie].self, from: favoritesData)
            guard !favorites.contains(where: ({$0.id == movieId})) else {
                self.showAlert(title: "This movie already in your favorites!", msg: "")
                return
            }
            favorites.append(self.movie!)
            let favoritesData = try! JSONEncoder().encode(favorites)
            Globals.App.ud.set(favoritesData, forKey: "favorites")
            
        } else {
            let favorites = [self.movie]
            let favoritesData = try! JSONEncoder().encode(favorites)
            Globals.App.ud.set(favoritesData, forKey: "favorites")
        }
        self.showAlert(title: "Added to your favorites!", msg: "")
    }
    
}

//MARK:- Tableview Delegate & Datasource

extension MovieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        
        var movie = self.recommendedMovies?[indexPath.row]
        cell.configureMovieCell(title: movie?.title, image: movie?.posterPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = storyboard!.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        detailVc.movieId = self.recommendedMovies?[indexPath.row].id
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    
}



class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
