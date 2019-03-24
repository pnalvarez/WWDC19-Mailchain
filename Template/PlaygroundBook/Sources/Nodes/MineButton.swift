//
//  MineButton.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 20/03/19.
//

import Foundation
import SpriteKit

public class MineButton: SKNode{
    
    public var spriteNode: SKSpriteNode?
    public var assets: [SKTexture] = [SKTexture(imageNamed: "MineButtonClickedBlue@3x"), SKTexture(imageNamed: "newMiningButton@3x")]
    
    public var clicked: Bool = false{
        didSet{
            if clicked{
                spriteNode?.texture = assets[0]
            }
            else{
                spriteNode?.texture = assets[1]
            }
        }
    }
    
    public override init(){
        super.init()
    }
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
       super.init()
        
        name = "Mine"
        
        spriteNode = SKSpriteNode(texture: assets[1])
        spriteNode?.position = CGPoint(x: x, y: y)
        spriteNode?.size = CGSize(width: width, height: height)
        spriteNode?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (spriteNode?.size.width)!, height: (spriteNode?.size.height)!))
        spriteNode?.physicsBody?.affectedByGravity = false
        
        guard let spritenode = spriteNode else{
            
            return
        }
        addChild(spritenode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func buttonClicked(){
        clicked = !clicked
    }
}
