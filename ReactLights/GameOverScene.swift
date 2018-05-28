//
//  GameOverScene.swift
//  ReactLights
//
//  Created by Martín Alegria Vizcaya on 25/05/18.
//  Copyright © 2018 Martín Alegria Vizcaya. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {

    let gameOver = SKLabelNode()
    let retry = SKLabelNode()
    let menu = SKLabelNode()
    let highScore = SKLabelNode()
    let scoreNum = SKLabelNode()
    
    let userDefs = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        let score = userDefs.integer(forKey: "highScore")
        
        self.backgroundColor = .white
        
        gameOver.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOver.text = "GAME OVER"
        gameOver.fontSize = 120
        gameOver.fontColor = .black
        self.addChild(gameOver)
        
        retry.position = CGPoint(x: frame.midX, y: frame.midY-200)
        retry.text = "RETRY"
        retry.fontSize = 80
        retry.fontColor = .black
        self.addChild(retry)
        
        menu.position = CGPoint(x: frame.midX, y: frame.midY-400)
        menu.text = "MENU"
        menu.fontSize = 80
        menu.fontColor = .black
        self.addChild(menu)
        
        highScore.position = CGPoint(x: frame.midX, y: frame.maxY-150)
        highScore.text = "SCORE"
        highScore.fontSize = 70
        highScore.fontColor = .black
        self.addChild(highScore)
        
        scoreNum.position = CGPoint(x: frame.midX, y: frame.maxY-400)
        scoreNum.text = String(score)
        scoreNum.fontSize = 300
        scoreNum.fontColor = .black
        self.addChild(scoreNum)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if retry.contains(location) {
            let game = GameScene()
            game.size = frame.size
            self.view?.presentScene(game)
        }else if menu.contains(location){
            let menu = MenuScene()
            menu.size = frame.size
            self.view?.presentScene(menu)
        }
    }
    
}
