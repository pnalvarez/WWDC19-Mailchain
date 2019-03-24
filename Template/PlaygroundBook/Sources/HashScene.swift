//
//  HashScene.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 16/03/19.
//

import Foundation
import SpriteKit
import AVFoundation

public class HashScene: SKScene, SKPhysicsContactDelegate, AVAudioPlayerDelegate {
    
    public var mailNode: Mail?
    public var paperNode: Paper?
    public var closingLetterPlayer: AVAudioPlayer?
    
    public var block: Block?{
        didSet{
            mailNode?.setHash(hashText: (block?.hashResult)!)
        }
    }
    
    public var hashLabel: SKLabelNode?
    public var backgroundNode: SKSpriteNode?
    public var score: UInt = 0
    public static var globalMessage: String = ""
    public let mailTexturesOpening: [String] = ["mail3", "mailOpening", "mailOpening2", "mailOpening3"]
    public let mailTexturesClosing: [String] = ["mailOpening3",  "mailOpening2", "mailOpening", "mail3"]
    public var letterOpened: Bool = false
    public var count: UInt = 0
    
    var playerTimer: Timer?
    
    public override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        self.closingLetterPlayer?.delegate = self
        
        block = Block(message: "Hello", previousHash: "", difficulty: 1)
        
//        mailNode = childNode(withName: "mail") as? SKSpriteNode
//        mailNode?.size = CGSize(width: size.width * 95/100, height: size.height * 35/100)
//        mailNode?.texture = SKTexture(imageNamed: "mail3")
        
        paperNode = Paper(message: "", width: frame.size.width * 0.6, height: frame.size.height/5, x: 0, y: frame.height * 1/5)
        paperNode?.name = "paper"
        addChild(paperNode!)
        
        mailNode = Mail(width: frame.size.width * 2/3, height: frame.size.height/4, x: 0, y: -frame.height * 1/5)
        mailNode?.name = "mail"
        mailNode?.translateHash()
        addChild(mailNode!)
        
        //        mailNode?.size.height *= 2
        //        mailNode?.size.width *= 1.3
        
        mailNode?.setHash(hashText: "")
        
        closingLetterPlayer = "closeLetter.mp3".createSoundPlayer()
        closingLetterPlayer?.numberOfLoops = 1
    }
    
    public func calculateHash(_ message: String){
        
        let newBlock = Block(message: message, previousHash: "", difficulty: 1)
        block = newBlock

        HashScene.globalMessage = message
    }
    
    public func changeHashLabel(_ text: String, _ color: UIColor){
        
        hashLabel?.text = text
        hashLabel?.color = color
    }

    public func writeInPaper(message: String){
        
        paperNode?.writeMessage(message: message)
    }
    
    public func fallLetter(){
        
        paperNode?.translate(x: 0, y: (mailNode?.position.y)! + (mailNode?.spriteNode?.size.height)!/2)
    }
    
    public func removeLetter(){
        
        paperNode?.removeFromParent()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag{
            closingLetterPlayer?.stop()
            closingLetterPlayer = nil
        }
      }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.node?.name == "paper"{
            bodyA.node?.removeFromParent()
        }
        
        if bodyB.node?.name == "mail"{
            bodyB.node?.removeFromParent()
        }
    }
//    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        let touch = touches.first
//        
//        if let place = touch?.location(in: self){
//            let theNodes = nodes(at: place)
//            
//            for node in theNodes{
//                if node.name == "mail"{
//                    if letterOpened{
//                        closeLetter()
//                    }
//                    else{
//                        openLetter()
//                    }
//                }
//            }
//        }
//    }
    
//    public func setUpHashLabel(){
//        
//        hashLabel = childNode(withName: "hashLabel") as? SKLabelNode
//        hashLabel?.color = UIColor.gray
//        hashLabel?.fontSize = CGFloat(40)
//        hashLabel?.fontColor = UIColor.black
//        hashLabel?.zPosition = 4
//        
//    }
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if paperNode?.position.y == (mailNode?.position.y)! + (mailNode?.spriteNode?.size.height)!/2{
            paperNode?.removeFromParent()
            calculateHash((paperNode?.messageLabel?.text)!)
            mailNode?.close()
            closingLetterPlayer?.play()
            letterOpened = true
        }
        if letterOpened{
            count += 1
        }
        if count > 10{
            closingLetterPlayer?.stop()
        }
    }
}
