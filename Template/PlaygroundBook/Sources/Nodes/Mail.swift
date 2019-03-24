//
//  Mail.swift
//  BookchainApp
//
//  Created by Pedro Alvarez on 20/03/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

public class Mail: SKNode{
    
    public var spriteNode: SKSpriteNode?
    public var hashLabel: SKLabelNode?
    public var nonceLabel: SKLabelNode?
    public var prevHashLabel: SKLabelNode?
    public static var fadeAction: SKAction?
    
    public var opened: Bool = true{
        didSet{
            if opened{
                spriteNode?.texture = SKTexture(imageNamed: "mailOpening3")
            }
            else{
                spriteNode?.texture = SKTexture(imageNamed: "mail3")
            }
        }
    }
    
    public var shiningPrevHash: Bool = false{
      didSet{
        if shiningPrevHash{
                prevHashLabel?.fontColor = UIColor(red: 255, green: 169, blue: 20, alpha: 1)
              }
        else{
                prevHashLabel?.fontColor = UIColor.brown
        }
    }
    }
    
    public var shiningHash: Bool = false{
        didSet{
            if shiningHash{
                hashLabel?.fontColor = UIColor(red: 255, green: 169, blue: 20, alpha: 1)
            }
            else{
                hashLabel?.fontColor = UIColor.black
            }
        }
    }
    
    public override init() {
        super.init()
    }
    
    public init( width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat ){
        super.init()
        
        position = CGPoint(x: x, y: y)
        spriteNode = SKSpriteNode(imageNamed: "mailOpening3")
        spriteNode?.size = CGSize(width: width, height: height)
        spriteNode?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (spriteNode?.size.width)!, height: (spriteNode?.size.height)!))
        spriteNode?.physicsBody?.categoryBitMask = BodyType.Mail.rawValue
        spriteNode?.physicsBody?.contactTestBitMask = BodyType.Letter.rawValue
        spriteNode?.physicsBody?.affectedByGravity = false
        
        hashLabel = SKLabelNode(text: "Hash: ")
        hashLabel?.position = CGPoint(x: 0 , y: -(spriteNode?.size.height)! * 3/10 )
        hashLabel?.fontSize = (spriteNode?.size.height)! / 10
        hashLabel?.fontColor = UIColor.black
        hashLabel?.fontName = "HelveticaNeue-Bold"
        
        nonceLabel = SKLabelNode(text: "")
        nonceLabel?.position = CGPoint(x: -(spriteNode?.size.width)! * 3/10, y: 0)
        nonceLabel?.fontSize = 20
        nonceLabel?.fontColor = UIColor.blue
        nonceLabel?.fontName = "HelveticaNeue-Bold"
        
        prevHashLabel = SKLabelNode(text: "")
        prevHashLabel?.position = CGPoint(x: 0, y: -(spriteNode?.size.height)! * 1/10)
        prevHashLabel?.fontSize = (spriteNode?.size.height)! / 10
        prevHashLabel?.fontColor = UIColor.brown
        prevHashLabel?.fontName = "HelveticaNeue-Bold"
        
        guard let hashlabel = hashLabel else{
            
            return
        }
        spriteNode?.addChild(hashlabel)
        
        guard let noncelabel = nonceLabel else{
            
            return
        }
        spriteNode?.addChild(noncelabel)
        
        guard let prevhashlabel = prevHashLabel else{
            
            return
        }
        spriteNode?.addChild(prevhashlabel)
        
        guard let sprite = spriteNode else{
            return
        }
        
        addChild(sprite)
        
        Mail.fadeAction = createAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setHash(hashText: String){
        
        self.hashLabel?.text = hashText
    }
    
    public func setNonce(nonceText: String){
        
        self.nonceLabel?.text =  nonceText
    }
    
    public func setPrevHash(prevHashText: String){
        
        self.prevHashLabel?.text = prevHashText
    }
    
    public func translateHash(){
        
        self.hashLabel?.position = CGPoint(x: 0, y: -(spriteNode?.size.height)! * 1/10)
    }
    
    public func initializeHashLabel(){
        
        hashLabel?.text = ""
    }
    
    public func close(){
        opened = false
    }
    
    public func open(){
        opened = true
    }
    
    public func translateMail(x: CGFloat, y: CGFloat    ){

            let translateAction = SKAction.move(to: CGPoint(x: x, y: y), duration: 0.5)
            run(translateAction)
        
    }
    
    public func shinePreviousHash(){
        shiningPrevHash = !shiningPrevHash
    }
    
    public func shineHash(){
        shiningHash = !shiningHash
    }
    
//    public func fadeLabel(label: SKLabelNode){
//
//        let fadeInAction = SKAction.fadeIn(withDuration: 0.1)
//        let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
//
//        let sequence = [fadeOutAction, fadeInAction, fadeOutAction, fadeInAction, fadeOutAction, fadeInAction, fadeOutAction, fadeInAction, fadeOutAction, fadeInAction]
//
//        let actionSequence = SKAction.sequence(sequence)
//        label.run(actionSequence)
//    }
    
    public func createAction() -> SKAction{
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.4)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.4)
        
        var sequence = [SKAction]()
        
        for i in 1...4{
            if i % 2 == 0{
                sequence.append(fadeInAction)
            }else{
                sequence.append(fadeOutAction)
            }
        }
        let action = SKAction.sequence(sequence)
        
        return action
    }
}

