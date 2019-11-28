//
//  AnimationNumbers.swift
//  Memory Game
//
//  Created by kavya saxena on 28/11/19.
//  Copyright © 2019 kavya saxena. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class AnimationNumbers: SKScene {
    var beeFrames:[SKTexture]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.clear
        var frames:[SKTexture] = []
        
        // refering .atlas file
        let beeAtlas = SKTextureAtlas(named: "Bee")
        
        //adding images to make frames for animation SKTexture array
        for index in 1 ... 6 {
            let textureName = "bee_\(index)"
            let texture = beeAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        self.beeFrames = frames

    }
    
    
    func flyBee() {
        let texture = self.beeFrames![0]
        let bee = SKSpriteNode(texture: texture)
        
        // adding size
        bee.size = CGSize(width: 140, height: 140)
        
        // randomly generating the position for occurrence
        let randomBeeYPositionGenerator = GKRandomDistribution(lowestValue: 50, highestValue: Int(self.frame.size.height))
        let yPosition = CGFloat(randomBeeYPositionGenerator.nextInt())
        
        let rightToLeft = arc4random() % 2 == 0
        
        let xPosition = rightToLeft ? self.frame.size.width + bee.size.width / 2 : -bee.size.width / 2
        
        bee.position = CGPoint(x: xPosition, y: yPosition)
        
        if rightToLeft {
            bee.xScale = -1
        }
        
        self.addChild(bee)
        
        bee.run(SKAction.repeatForever(SKAction.animate(with: self.beeFrames!, timePerFrame: 0.05, resize: false, restore: true)))
        
        var distanceToCover = self.frame.size.width + bee.size.width
        
        if rightToLeft {
            distanceToCover *= -1
        }
        
        let time = TimeInterval(abs(distanceToCover / 140))
        
        let moveAction = SKAction.moveBy(x: distanceToCover, y: 0, duration: time)
        
        let removeAction = SKAction.run {
            bee.removeAllActions()
            bee.removeFromParent()
        }
        
        let allActions = SKAction.sequence([moveAction, removeAction])
        
        bee.run(allActions)
        
        
        
    }
    
    
}
