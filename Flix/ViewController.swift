//
//  ViewController.swift
//  Flix
//
//  Created by Ebuka Egbunam on 6/9/20.
//  Copyright © 2020 Ebuka Egbunam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //iboutlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    var Movies : Response?
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
    
    
    func setUpTableview()  {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }


}


extension ViewController : UITableViewDelegate , UITableViewDataSource {
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
            cell.titleLabel.text = Movies.results[indexPath.row].title
            cell.descriptionLabel.text  = Movies.results[indexPath.row].overview
            
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
    
    
    
}

