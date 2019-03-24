//
//  Paper.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 20/03/19.
//

import Foundation
import SpriteKit

public class Paper: SKNode{
    
    public var spriteNode: SKSpriteNode?
    public var messageLabel: SKLabelNode?
    
    public override init(){
        super.init()
    }
    
    public init(message: String, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) {
        super.init()
        
        spriteNode = SKSpriteNode(imageNamed: "Paper")
        spriteNode?.size = CGSize(width: width, height: height)
//        spriteNode?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (spriteNode?.size.width)!, height: (spriteNode?.size.height)!))
//        spriteNode?.physicsBody?.categoryBitMask = BodyType.Letter.rawValue
//        spriteNode?.physicsBody?.contactTestBitMask = BodyType.Mail.rawValue
//        spriteNode?.physicsBody?.affectedByGravity = false
//        
        position = CGPoint(x: x, y: y)
        
        guard let spritenode = spriteNode else{
            
            return
        }
        addChild(spritenode)
        
        messageLabel = SKLabelNode(text: message)
        messageLabel?.position = CGPoint(x: 0, y: 0)
        messageLabel?.fontSize = 20
        messageLabel?.fontColor = UIColor.black
        messageLabel?.fontName = "HelveticaNeue-Bold"
        
        guard let messagelabel = messageLabel else {
            
            return
        }
        
        spriteNode?.addChild(messagelabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func writeMessage(message: String){
        
        messageLabel?.text = message
    }
    
    public func translate(x: CGFloat, y: CGFloat){
        
        let waitAction = SKAction.wait(forDuration: 0)
        let translateAction = SKAction.move(to: CGPoint(x: x, y: y), duration: 2)
        let action = SKAction.sequence([waitAction, translateAction])
        
        run(action)
    }
}
