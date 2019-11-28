//
//  GameEnd.swift
//  Memory Game
//
//  Created by kavya saxena on 28/11/19.
//  Copyright © 2019 kavya saxena. All rights reserved.
//

import UIKit
import SpriteKit
class GameEnd: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var sceneView: SKView!
    var score : Int?
    var scene: AnimationNumbers?
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score \(score!)"
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                //
        self.scene = AnimationNumbers(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)
        
        for _ in 1...10{
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.scene!.flyBee()
                 }
            }
    }
    @IBAction func playAgainPressed(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "homeScreen") as! ViewController
        self.present(next, animated: true, completion: nil)
    }
}
