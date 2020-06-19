//
//  ViewController.swift
//  Flix
//
//  Created by Ebuka Egbunam on 6/9/20.
//  Copyright © 2020 Ebuka Egbunam. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    
    //iboutlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var Movies : Response?
    var indePathlicked : Int?
    var detailSegue = "detail"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        setUpCollection()
        Api.getMovies { [weak self] (data) in
            
            guard let self = self else {return}
            self.Movies = data
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegue {
            if  let vc = segue.destination as? DetailViewController {
                
                if let indexPathClicked = indePathlicked {
                    if let movies = Movies {
                        vc.r = movies.results[indexPathClicked]
                    }
                   
                }
                
                
            }
        }
    }
    
    func setUpCollection() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        moviesCollectionView.collectionViewLayout = flowLayout

    }

    
}



extension ViewController :  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let Movies = Movies else {
            return 5
        }
        return Movies.results.count

        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let Movies = Movies else {
             let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            return cell
        }
        
        let movie = Movies.results[indexPath.row]
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoviesCollectionViewCell
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.layer.cornerRadius = 7
        cell.imageView.af.setImage(withURL: Api.getImageUrl(movie: movie))
        cell.backgroundColor = .clear
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.1
        let height = collectionView.frame.height / 2
        
        let size = CGSize(width: width, height: height)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indePathlicked = indexPath.row
        performSegue(withIdentifier: detailSegue, sender: self)
    }
    
    
    
}







