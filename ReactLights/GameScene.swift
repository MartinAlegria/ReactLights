//
//  GameScene.swift
//  ReactLights
//
//  Created by Martín Alegria Vizcaya on 24/05/18.
//  Copyright © 2018 Martín Alegria Vizcaya. All rights reserved.
// DARK MODE = 11 PERCENT

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    let userDefs = UserDefaults.standard
    var pause = false
    
    var lights: [SKShapeNode] = []
    
    let startScreen = SKSpriteNode()
    let pauseScreen = SKSpriteNode()
    var start = false
    
    let light1 = SKShapeNode(circleOfRadius: 100)
    let light2 = SKShapeNode(circleOfRadius: 100)
    let light3 = SKShapeNode(circleOfRadius: 100)
    let light4 = SKShapeNode(circleOfRadius: 100)
    let light5 = SKShapeNode(circleOfRadius: 100)
    let light6 = SKShapeNode(circleOfRadius: 100)
    
    var correctLight = SKShapeNode()
    var fakeLight = SKShapeNode()
    
    var colors: [SKColor] = []
    
    let blue = SKColor(red: 9/255, green: 54/255, blue: 188/255, alpha: 1)
    let red = SKColor(red: 188/255, green: 9/255, blue: 9/255, alpha: 1)
    let green = SKColor(red: 9/255, green: 188/255, blue: 90/255, alpha: 1)
    let cyan = SKColor(red: 9/255, green: 188/255, blue: 179/255, alpha: 1)
    let yellow = SKColor(red: 226/255, green: 198/255, blue: 13/255, alpha: 1)
    
    let correctColorWindow = SKShapeNode(rectOf: CGSize(width: 150, height: 200))
    var correctColor = SKColor()
    var fakeColor = SKColor()
    
    var gameTime = 30
    var gameTimer = Timer()
    
    var score = 0
    
    let timerLabel = SKLabelNode(fontNamed: "Arial")
    let scoreLabel = SKLabelNode(fontNamed: "Arial")
    
    func colorsFunc() -> SKColor{
        colors.append(blue)
        colors.append(red)
        colors.append(green)
        colors.append(cyan)
        colors.append(yellow)
        
        let correctColor = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[correctColor]
        
    }//colorsFunc
    
    func fakeColorSet() -> SKColor{
        let correct = correctColor
        var incorrectColor = Int(arc4random_uniform(UInt32(colors.count)))
        
        if colors[incorrectColor] == correct{
            repeat{
                incorrectColor = Int(arc4random_uniform(UInt32(colors.count)))
            }while colors[incorrectColor] == correct
        }//if
        
        return colors[incorrectColor]
    }//fakeColor

    
    @objc func time(){
        gameTime -= 1
        timerLabel.text = String(gameTime)
        
        if gameTime == 0{
            gameTimer.invalidate()
            userDefs.set(score, forKey: "highScore")
            
            let gameOver = GameOverScene()
            gameOver.size = frame.size
            let trans = SKTransition.reveal(with: SKTransitionDirection.up, duration: 1)
            self.view?.presentScene(gameOver, transition: trans)
        }
    }
    
    func timerSetUp(){
        timerLabel.position = CGPoint(x: frame.midX + 225, y: frame.maxY - 160)
        timerLabel.fontColor = SKColor.black
        timerLabel.fontSize = 100
        timerLabel.text = String(gameTime)
        self.addChild(timerLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.time), userInfo: nil, repeats: true)
        
    }
    
    func scoreSetUp(){
        scoreLabel.position = CGPoint(x: frame.midX - 225, y: frame.maxY - 160)
        scoreLabel.fontColor = SKColor.black
        scoreLabel.fontSize = 90
        scoreLabel.text = String(score)
        self.addChild(scoreLabel)
        
    }
    
    //TOUCHES BEGAN  *******************************************************************************************
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        if !start{
            
            if startScreen.contains(touchLocation){
                start = true
                startScreen.isHidden = true
                play()
            }
            
        }
        
        if correctLight.contains(touchLocation) && !pause{
            score += 1
            scoreLabel.text = String(score)
            correctColor = colorsFunc()
            fakeColor = fakeColorSet()
            correctColorWindow.fillColor = correctColor
            randomCircle()
            
        }else if fakeLight.contains(touchLocation) && !pause{
            
            scoreLabel.text = String(score)
            correctColor = colorsFunc()
            fakeColor = fakeColorSet()
            correctColorWindow.fillColor = correctColor
            randomCircle()
        }else if correctColorWindow.contains(touchLocation) && pause == false{
            
            gameTimer.invalidate()
            pause = true
            pauseScreen.isHidden = false
        }else if correctColorWindow.contains(touchLocation) && pause == true{
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.time), userInfo: nil, repeats: true)
            pause = false
            pauseScreen.isHidden = true
        }
        
    }

    //DID MOVE  *******************************************************************************************
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        correctColor = colorsFunc()
        fakeColor = fakeColorSet()
        setUpUI()
    }
    
    func play(){
        timerSetUp()
        scoreSetUp()
        randomCircle()
    }
    
    func setUpUI(){
        light1.position = CGPoint(x: frame.midX - 200, y: frame.maxY-400)
        light1.lineWidth = 0
        lights.append(light1)
        
        light2.position = CGPoint(x: frame.midX + 200, y: frame.maxY-400)
        light2.lineWidth = 0
        lights.append(light2)
        
        light3.position = CGPoint(x: frame.midX - 200, y: frame.maxY-750)
        light3.lineWidth = 0
        lights.append(light3)
        
        light4.position = CGPoint(x: frame.midX + 200, y: frame.maxY-750)
        light4.lineWidth = 0
        lights.append(light4)
        
        light5.position = CGPoint(x: frame.midX - 200, y: frame.maxY-1100)
        light5.lineWidth = 0
        lights.append(light5)
        
        light6.position = CGPoint(x: frame.midX + 200, y: frame.maxY-1100)
        light6.lineWidth = 0
        lights.append(light6)
        
        self.addChild(light1)
        self.addChild(light2)
        self.addChild(light3)
        self.addChild(light4)
        self.addChild(light5)
        self.addChild(light6)
        
        correctColorWindow.position = CGPoint(x: frame.midX, y: frame.maxY - 130)
        correctColorWindow.fillColor = correctColor
        correctColorWindow.lineWidth  = 0
        self.addChild(correctColorWindow)
        
        self.backgroundColor = .white
        
        startScreen.size = frame.size
        startScreen.texture = SKTexture(image: UIImage(named: "startScreenText")!)
        startScreen.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(startScreen)
        
        pauseScreen.size = frame.size
        pauseScreen.texture = SKTexture(image: UIImage(named: "pauseScreen")!)
        pauseScreen.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(pauseScreen)
        pauseScreen.isHidden = true
        
    }
    
    func randomCircle(){
        let rand1 = Int(arc4random_uniform(UInt32(lights.count)))
        var rand2 = Int(arc4random_uniform(UInt32(lights.count)))
        
        if rand2 == rand1{
            repeat{
                rand2 = Int(arc4random_uniform(UInt32(lights.count)))
            }while rand2 == rand1
        }//if
        
        for light in lights {
            
            if light == lights[rand1] || light == lights[rand2]{
                
                lights[rand1].isHidden = false
                lights[rand1].fillColor = correctColor
                correctLight = lights[rand1]
                
                lights[rand2].isHidden = false
                lights[rand2].fillColor = fakeColor
                fakeLight = lights[rand2]
                
            }else{
                light.isHidden = true
            }
            
        }//for
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
