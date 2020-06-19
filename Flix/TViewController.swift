//
//  TViewController.swift
//  Flix
//
//  Created by Ebuka Egbunam on 6/19/20.
//  Copyright © 2020 Ebuka Egbunam. All rights reserved.
//

import UIKit
import AlamofireImage

class TViewController: UIViewController {
    
    //iboutlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    var Movies : Response?
    var indePathlicked : Int?
    var detailSegue = "detail"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        setUpTableview()
        Api.getMovies { [weak self] (data) in
            
            guard let self = self else {return}
            self.Movies = data
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
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
    
    func setUpTableview()  {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    


}


extension TViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let Movies = Movies else {
            return 5
        }
        return Movies.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let Movies = Movies else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "The api failed sorry"
            return cell
            
        }
        
        if let cell = moviesTableView.dequeueReusableCell(withIdentifier: "cell") as? MoviesTableViewCell {
            
            let movie = Movies.results[indexPath.row]
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text  = movie.overview
            cell.MoviewImageView.af.setImage(withURL: Api.getImageUrl(movie: movie))
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = Movies.results[indexPath.row].title
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indePathlicked = indexPath.row
        performSegue(withIdentifier: detailSegue, sender: self)
        
    }
    
    
    
}




