//
//  GameViewController.swift
//  Memory Game
//
//  Created by kavya saxena on 27/11/19.
//  Copyright © 2019 kavya saxena. All rights reserved.
//

import UIKit
import  SpriteKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var ten: UIImageView!
    
    @IBOutlet weak var five: UIImageView!
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0 {
        didSet{
            scoreLabel.text = String(score)
        }
    }
    
    var noOfCells: Int = 9
    var letterCellArray = [String]()
    var lettersArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var cardsshown = [IndexPath]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let num = Int(noOfCells/2)
        letterCellArray = Array(lettersArray[0..<num])
        letterCellArray.append(contentsOf: letterCellArray)
        if(noOfCells%2==1){
            letterCellArray.append(lettersArray[0])
        }
        letterCellArray.shuffle()
        print(letterCellArray)
        }

    
    //Mark: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! cardView
        print(indexPath.row)
        cell.backgroundColor = .white
        cell.cardLabel?.text = letterCellArray[indexPath.row]
        return cell
    }
   
    
    //Mark: - UICollectionViewDelegateFlowLayout
    internal func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.frame.height/CGFloat(noOfCells/3)
        let mulHeight = 10 * CGFloat(noOfCells/3)
        let width = collectionView.frame.width/3
        let itemWidth: CGFloat = width - 20
        let itemHeight: CGFloat = height - (mulHeight/8) - 10
        return CGSize(width: itemWidth, height: itemHeight)
    }

    
    //Mark: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:cardView = collectionView.cellForItem(at: indexPath) as! cardView
        if cell.shown {
            return
        }
        
        cell.shown = true // value check if carded is opened proirly or not
        if(cardsshown.count%2 == 0){
        cardsshown.append(indexPath)
        cell.showCard(show: true, animted: true)
            // checking if all the cards are opened or not
            if cardsshown.count==noOfCells{
               let next = self.storyboard?.instantiateViewController(withIdentifier: "gameEnd") as! GameEnd
                next.score = score
               self.present(next, animated: true, completion: nil)
            }
        
        }
        else {
            let cell1:cardView = collectionView.cellForItem(at: cardsshown.last!) as! cardView
            
            // Checking if the text of last card opened and present card is equal or not
            if(cell1.cardLabel!.text!.isEqual(cell.cardLabel?.text)){
                
                // if equal add 10 points
                cardsshown.append(indexPath)
                cell.showCard(show: true, animted: true)
                score += 10
            
                // animation for points added
                ten.isHidden = false
                ten.startAnimating()
                ten.animationDuration = 0.2
                ten.animationRepeatCount = 1
                let seconds = 0.2
                // adding delay
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.ten.isHidden = true
                }
                // checking if all the cards are opened or not
                if cardsshown.count==noOfCells{
                   let next = self.storyboard?.instantiateViewController(withIdentifier: "gameEnd") as! GameEnd
                    next.score = score
                   self.present(next, animated: true, completion: nil)
                }
                
            }
            else {
                
                // if not equal sub 5 points
                cell.showCard(show: true, animted: true)
                
                cardsshown.removeLast()
                if cell.priorshow{
                score -= 5
                five.isHidden = false
                five.startAnimating()
                    five.animationDuration = 0.2
                five.animationRepeatCount = 1
                    let seconds = 0.2
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                 self.five.isHidden = true
                 }
                    
                    
            }
                cell1.shown = false
                cell.shown = false
            // adding delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                cell.showCard(show: false, animted: true)
            }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    cell1.showCard(show: false, animted: true)
            }
            
        }
    }
    
     cell.priorshow = true

 }
}
