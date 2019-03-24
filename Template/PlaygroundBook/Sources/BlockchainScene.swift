//
//  BlockchainScene.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 18/03/19.
//

import Foundation
import SpriteKit
import AVFoundation

public class BlockchainScene: SKScene, SKPhysicsContactDelegate{
    
    public var paperNode: Paper?
    public var newMailNode: Mail?
    public var miningPlayer: AVAudioPlayer?
    public var placingLetterPlayer: AVAudioPlayer?
    public var opened: Bool = true
    public var canMine: Bool = false{
        didSet{
            if canMine{
                miningPlayer?.play()
            }
            else{
                miningPlayer?.stop()
            }
        }
    }
    public var difficulty: UInt = 1
    public var removedPaper: Bool = false
    public var buttonCreated: Bool = false      
    public var nonce: UInt = 0{
        didSet{
            newMailNode?.setNonce(nonceText: "Nonce: \(nonce)")
        }
    }
    public var newBlock: Block?{
        didSet{
            newMailNode?.setHash(hashText: (newBlock?.hashResult)!)
        }
    }
    public var mineButton: MineButton?
    public var prevHash: String = ""
    public var message: String = ""
    public var lastMailPosition: CGPoint?
    public var thirdMail: Mail?
    public var shineNumber: UInt = 0
    
    public var shine: Bool = false
    
    public override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        prevHash = "0278f3a65b"
        newBlock = Block(message: "", nonce: 0, previousHash: prevHash, difficulty: difficulty)
        paperNode = Paper(message: "Cruzeiro é legal", width: frame.width * 1/3, height: frame.height * 1/10, x: 0, y: -frame.height * 1/4)
        paperNode?.name = "Paper"
        
        guard let papernode = paperNode else{
            return
        }
        addChild(papernode)
        
        newMailNode = Mail(width: frame.width * 4/9, height: frame.height * 1/6, x: -frame.width, y: -frame.height * 1/4)
        newMailNode?.name = "new Mail"
        newMailNode?.setHash(hashText: "")
        
        guard let newmailnode = newMailNode else{
            return
        }
        
        addChild(newmailnode)
        
        placePreviousLetters()
        
        miningPlayer = "Keyboard_Typing_Fast.mp3".createSoundPlayer()
        placingLetterPlayer = "Flipping_Newspaper_Pages.mp3".createSoundPlayer()
    }
    
    public func writeLetter(message: String){
        
        paperNode?.messageLabel?.text = message
        self.message = message
    }
    
    public func bringLetter(){
        
        let translateAction = SKAction.move(to: CGPoint(x: (paperNode?.position.x)! - (paperNode?.spriteNode?.size.width)! / 2, y: (paperNode?.position.y)!), duration: 1)
        newMailNode?.run(translateAction, completion: {
            
            self.paperNode?.removeFromParent()
            self.newMailNode?.close()
            self.newMailNode?.setPrevHash(prevHashText: "Previous Hash: 0091ab1027")
            self.newMailNode?.setNonce(nonceText: "Nonce: 0")
            self.calculateHash(message: self.message)
            
            self.newMailNode?.prevHashLabel!.run(Mail.fadeAction!)
            self.thirdMail?.hashLabel?.run(Mail.fadeAction!, completion: {
                
                self.createMineButton()
                })
//            self.newMailNode?.fadeLabel(label: (self.newMailNode?.prevHashLabel)!)
//            self.thirdMail?.fadeLabel(label: (self.thirdMail?.hashLabel)!)
            })
    }
    
    public func calculateHash(message: String){
        
        let block = Block(message: message, previousHash: "0091ab1027", difficulty: difficulty)
        newBlock = block
        newMailNode?.setNonce(nonceText: "Nonce: \(newBlock?.nonce ?? 0)")
        HashScene.globalMessage = message
    }
    
    public func createMineButton(){
        
        mineButton = MineButton(x: (newMailNode?.position.x)! + (newMailNode?.spriteNode?.size.width)! / 2 + frame.size.width / 10, y: (newMailNode?.position.y)!, width: frame.size.width / 4, height: frame.size.height / 15)
        mineButton?.name = "Mine Button"
        addChild(mineButton!)
    }
    
    public func placeOnBlockchain(mail: Mail){
        
        placingLetterPlayer?.play()
        let placeAction = SKAction.move(to: lastMailPosition!, duration: 0.5)
        newMailNode?.run(placeAction, completion: {
            self.placingLetterPlayer?.stop()
        })
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let place =  touch?.location(in: self){
            let theNodes = nodes(at: place)
            
            for node in theNodes{
                if node.name == "Mine Button"{
                    mineButton?.buttonClicked()
                    mineButton?.removeFromParent()
                    canMine = true
                    //                        mailNode?.nonceLabel!.text = "oieoieoeioe"
                }
            }
        }
    }
    
    public func mineBlock(){
        
        var str = ""
        
        for _ in 1...difficulty{
            str += "0"
        }
        if(String((newBlock?.hashResult.prefix(Int(difficulty)))!) != str){
            nonce += 1
            let block = Block(message: (newBlock?.message)!, nonce: nonce, previousHash: (newBlock?.previousHash)!, difficulty: difficulty)
            newBlock = block
        }else{
            canMine = false
            placeOnBlockchain(mail: newMailNode!)
        }
    }
    
    public func placePreviousLetters(){
        
        let firstMail = Mail(width: frame.width * 4/9, height: frame.height * 1/6, x: 0, y: frame.height * 33/100)
        addChild(firstMail)
        firstMail.setHash(hashText: "Hash: 1828283683")
        firstMail.setNonce(nonceText: "Nonce: 0")
        firstMail.setPrevHash(prevHashText: "Previous Hash: 0000000000")
        firstMail.close()
        
        let secondMail = Mail(width: frame.width * 4/9, height: frame.height * 1/6, x: 0, y: firstMail.position.y - firstMail.spriteNode!.size.height / 2 - frame.size.height / 12)
        secondMail.setHash(hashText: "Hash: 00f383a838")
        secondMail.setNonce(nonceText: "Nonce: 118")
        secondMail.setPrevHash(prevHashText: "Previous Hash: 1828283683")
        secondMail.close()
        addChild(secondMail)


        thirdMail = Mail(width: frame.width * 4/9, height: frame.height * 1/6, x: 0, y: secondMail.position.y - secondMail.spriteNode!.size.height / 2 - frame.size.height / 12)
        thirdMail!.setHash(hashText: "Hash: 0091ab1027")
        thirdMail!.setNonce(nonceText: "Nonce: 799")
        thirdMail!.setPrevHash(prevHashText: "Previous Hash: 00f383a838")
        thirdMail!.close()
        addChild(thirdMail!)
        
        let fourthMail = Mail(width: frame.width * 4/9, height: frame.height * 1/6, x: 0, y: thirdMail!.position.y - thirdMail!.spriteNode!.size.height / 2 - frame.size.height / 12)
        
        let firstMailBotton = (firstMail.position.y) - ((firstMail.spriteNode?.size.height)!*0.88) / 2
        let secondMailTop = (secondMail.position.y) + ((secondMail.spriteNode?.size.height)!*0.88) / 2
        
        let firstChain = SKSpriteNode(imageNamed: "chain")
        addChild(firstChain)
        firstChain.position = CGPoint(x: 0, y: (firstMailBotton + secondMailTop) / 2)
        firstChain.size = CGSize(width: (firstMail.spriteNode?.size.width)! / 10, height: firstMailBotton - secondMailTop)
//        firstChain.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: firstChain.size.width, height: firstChain.size.height))
//        firstChain.physicsBody?.affectedByGravity = false
        
        let secondMailBotton = (secondMail.position.y) - ((secondMail.spriteNode?.size.height)!*0.88) / 2
        let thirdMailTop = (thirdMail!.position.y) + ((thirdMail!.spriteNode?.size.height)!*0.88) / 2
        
        let secondChain = SKSpriteNode(imageNamed: "chain")
        addChild(secondChain)
        secondChain.position = CGPoint(x: 0, y: (secondMailBotton + thirdMailTop) / 2)
        secondChain.size = CGSize(width: (firstMail.spriteNode?.size.width)! / 10, height: firstMailBotton - secondMailTop)
//        secondChain.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: secondChain.size.width, height: secondChain.size.height))
//        secondChain.physicsBody?.affectedByGravity = false

        
        let thirdMailBotton = (thirdMail!.position.y) - ((thirdMail!.spriteNode?.size.height)!*0.88) / 2
        let fourthMailTop = (fourthMail.position.y) + ((fourthMail.spriteNode?.size.height)!*0.88) / 2
        
        let thirdChain = SKSpriteNode(imageNamed: "chain")
        addChild(thirdChain)
        thirdChain.position = CGPoint(x: 0, y: (thirdMailBotton + fourthMailTop) / 2)
        thirdChain.size = CGSize(width: (firstMail.spriteNode?.size.width)! / 10, height: thirdMailBotton - fourthMailTop)
//        thirdChain.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: thirdChain.size.width, height: thirdChain.size.height))
//        thirdChain.physicsBody?.affectedByGravity = false

        lastMailPosition = fourthMail.position
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
//        if (paperNode?.position.x)! + (paperNode?.spriteNode!.size.width)! == (newMailNode?.position.x)! - (newMailNode?.spriteNode?.size.width)!/2{
//            newMailNode?.close()
//            newMailNode?.spriteNode?.texture = SKTexture(imageNamed: "mail3")
//            newMailNode?.setPrevHash(prevHashText: "Previous Hash: 0091ab1027")
//            newMailNode?.setNonce(nonceText: "Nonce: 0")
//            calculateHash(message: message)
//        }
        if canMine{
            mineBlock()
        }
        if shine{
            
        }
    }
    
}
