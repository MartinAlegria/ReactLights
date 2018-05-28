//
//  MenuScene.swift
//  ReactLights
//
//  Created by Martín Alegria Vizcaya on 25/05/18.
//  Copyright © 2018 Martín Alegria Vizcaya. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    let label = SKLabelNode()
    let play = SKLabelNode()
    let game = GameScene()

    override func didMove(to view: SKView) {
        
        self.backgroundColor = .white
        
        label.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        label.text = "REACT LIGHTS"
        label.fontSize = 100
        label.fontColor = .black
        self.addChild(label)
        
        play.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        play.text = "PLAY"
        play.fontSize = 100
        play.fontColor = .black
        self.addChild(play)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if play.contains(location){
            let trans = SKTransition.reveal(with: SKTransitionDirection.up, duration: 1)
            game.size = frame.size
            self.view?.presentScene(game, transition: trans)
            
        }
        
    }
    
    
}
