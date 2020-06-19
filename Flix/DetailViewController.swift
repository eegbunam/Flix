//
//  DetailViewController.swift
//  Flix
//
//  Created by Ebuka Egbunam on 6/19/20.
//  Copyright © 2020 Ebuka Egbunam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var r : Result?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    
        
        
    }
    
    func setUpView(){
        coverImage.contentMode = .scaleAspectFill
        titleImage.contentMode = .scaleAspectFill
        
        
        if let result = r {
            title = result.title
            titileLabel.text = result.title
            DateLabel.text = result.release_date
            coverImage.af.setImage(withURL: Api.getBackImageUrl(movie: result))
            titleImage.af.setImage(withURL: Api.getImageUrl(movie: result))
            descriptionLabel.text = result.overview
        }
    }
    
    
    
    
}


