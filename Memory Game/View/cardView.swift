//
//  cardView.swift
//  Memory Game
//
//  Created by kavya saxena on 28/11/19.
//  Copyright © 2019 kavya saxena. All rights reserved.
//

import UIKit

class cardView: UICollectionViewCell {
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    
    var shown: Bool = false // value to check wheteher the card is shown priorly or not
    var priorshow: Bool = false
    // MARK: - Methods

    func showCard(show: Bool, animted: Bool) {
        // flip animation to show card
        if animted {
            if show {
                UIView.transition(from: cardLabel,
                                  to: defaultImage,
                    duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { (finished: Bool) -> () in
                    })
                defaultImage.isHidden = true
                cardLabel.isHidden = false
            } else {
                UIView.transition(from: defaultImage,
                                  to: cardLabel,
                    duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion:  { (finished: Bool) -> () in
                    })
                defaultImage.isHidden = false
                cardLabel.isHidden = true
            }
        } else {
            if show {
                bringSubviewToFront(defaultImage)
                cardLabel.isHidden = true
            } else {
                bringSubviewToFront(cardLabel)
                defaultImage.isHidden = true
            }
        }
    }
}
