//
//  HashScene.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 16/03/19.
//

import Foundation
import SpriteKit
import AVFoundation

public class MineScene: SKScene, SKPhysicsContactDelegate {
    
    public var mailNode: Mail?
    public var paperNode: Paper?
    public var mineButton: MineButton?
    public var miningPlayer: AVAudioPlayer?
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
    public var canMine: Bool = false
    public var difficulty: UInt = 1
    public var removedPaper: Bool = false
    public var buttonCreated: Bool = false
    public var nonce: UInt = 0{
        didSet{
            mailNode?.setNonce(nonceText: "Nonce: \(nonce)")
        }
    }
    
    public var count: UInt = 0
    
    public override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.view?.backgroundColor = UIColor(red: 62, green: 99, blue: 139, alpha: 1)
        
        block = Block(message: "Hello", previousHash: "", difficulty: difficulty)
        
        //        mailNode = childNode(withName: "mail") as? SKSpriteNode
        //        mailNode?.size = CGSize(width: size.width * 95/100, height: size.height * 35/100)
        //        mailNode?.texture = SKTexture(imageNamed: "mail3")
        
        paperNode = Paper(message: "", width: frame.size.width * 0.6, height: frame.size.height/5, x: 0, y: frame.height * 1/5)
        paperNode?.name = "paper"
        addChild(paperNode!)
        
        mailNode = Mail(width: frame.size.width * 2/3, height: frame.size.height/4, x: 0, y: -frame.height * 1/5)
        mailNode?.name = "mail" 
        addChild(mailNode!)
        
        //        mailNode?.size.height *= 2
        //        mailNode?.size.width *= 1.3
        
        mailNode?.setHash(hashText: "")
        mailNode?.setNonce(nonceText: "Nonce: \(nonce)")
        
        miningPlayer = "Keyboard_Typing_Fast.mp3".createSoundPlayer()
        closingLetterPlayer = "closeLetter.mp3".createSoundPlayer()
    }
    
    public func calculateHash(_ message: String){
        
        let newBlock = Block(message: message, previousHash: "", difficulty: difficulty)
        block = newBlock
        mailNode?.setNonce(nonceText: "Nonce: \(block?.nonce ?? 0)")
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
    
    public func createMineButton(){
        
        
        
        mineButton = MineButton(x: 0, y: 0, width: frame.width/4, height: frame.height/15)
        addChild(mineButton!)
        buttonCreated = true
    }
    
    public func mine(_ difficulty: UInt){
        
        var nonce = 0
        
        var str = ""
        
        for _ in 1...difficulty{
            str += "0"
        }
        
        if(String((block?.hashResult.prefix(Int(difficulty)))!) != str){
            nonce += 1
            let newBlock = Block(message: (block?.message)!, nonce: UInt(nonce), previousHash: "", difficulty: difficulty)
            block = newBlock
        }else{
            canMine = false
            miningPlayer?.stop()
        }
    }
    
    public func mineBlock(){
        
        var str = ""
        
        for _ in 1...difficulty{
            str += "0"
        }
        if(Hash.hash((block?.message)!, nonce).prefix(Int(difficulty)) != str){
            nonce += 1
            let newBlock = Block(message: (block?.message)!, nonce: nonce, previousHash: (block?.previousHash)!, difficulty: difficulty)
            block = newBlock
        }else{
            canMine = false
            miningPlayer?.stop()
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let place =  touch?.location(in: self){
            let theNodes = nodes(at: place)
            
            for node in theNodes{
                if node.name == "Mine"{
                    mineButton?.buttonClicked()
                    mineButton?.removeFromParent()
                    canMine = true
                    miningPlayer?.play()
                    //                        mailNode?.nonceLabel!.text = "oieoieoeioe"
                }
            }
        }
    }
    
//    public func createSoundPlayer(resource: String) -> AVAudioPlayer?{
//
//        let path = Bundle.main.path(forResource: resource, ofType: nil)
//        let url = URL(fileURLWithPath: path!)
//
//        do{
//            let soundEffect = try AVAudioPlayer(contentsOf: url)
//            return soundEffect
//        }
//        catch{
//            return nil
//        }
//    }
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
            
            if !removedPaper{
                paperNode?.removeFromParent()
                calculateHash((paperNode?.messageLabel?.text)!)
                mailNode?.close()
                closingLetterPlayer?.play()
                removedPaper = true
            }
            if !buttonCreated{
                createMineButton()
            }
            if canMine{
                mineBlock()
            }
            if letterOpened{
                count += 1
            }
            if count > 10{
                closingLetterPlayer?.stop()
            }
        }
    }
}
