//
//  BeerTableViewCell.swift
//  BeerApi
//
//  Created by André Brilho on 13/08/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit
import AlamofireImage

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleBeer: UILabel!
    @IBOutlet weak var infoBeer: UILabel!
    @IBOutlet weak var imgBeer: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgStar: UIImageView!
    
    var beer:Beer!{
        didSet{
            setBeer()
        }
    }

    func setBeer(){
        
        if beer.favorito {
            imgStar.image = UIImage.init(named: "star")
        }else{
            imgStar.image = nil
        }
        
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        titleBeer.text = beer.name
        infoBeer.text = String(beer.abv)
        imgBeer.image = nil
        imgBeer.af_cancelImageRequest()
        activityIndicator.startAnimating()
        imgBeer.af_setImage(withURL: URL(string:beer.image_url)!, filter: AspectScaledToFitSizeFilter(size: CGSize(width: 45, height: 60)), imageTransition: .crossDissolve(0.7), runImageTransitionIfCached: true, completion: { (_) in
            self.activityIndicator.stopAnimating()
        }
        )}
    
    
    
}
