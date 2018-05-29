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
    let model = UIDevice.modelName
    
    func fontSize() -> CGFloat{
        if model == "iPhone X" || model == "Simulator iPhone X"{return 60}
        else{return 80}
    }
    
    func goFontSize() -> CGFloat{
        if model == "iPhone X" || model == "Simulator iPhone X"{return 100}
        else{return 120}
    }

    
    let userDefs = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        let score = userDefs.integer(forKey: "highScore")
        
        self.backgroundColor = .white
        
        gameOver.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOver.text = "GAME OVER"
        gameOver.fontSize = goFontSize()
        gameOver.fontColor = .black
        self.addChild(gameOver)
        
        retry.position = CGPoint(x: frame.midX, y: frame.midY-200)
        retry.text = "RETRY"
        retry.fontSize = fontSize()
        retry.fontColor = .black
        self.addChild(retry)
        
        menu.position = CGPoint(x: frame.midX, y: frame.midY-400)
        menu.text = "MENU"
        menu.fontSize = fontSize()
        menu.fontColor = .black
        self.addChild(menu)
        
        highScore.position = CGPoint(x: frame.midX, y: frame.maxY-150)
        highScore.text = "SCORE"
        highScore.fontSize = 80
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
