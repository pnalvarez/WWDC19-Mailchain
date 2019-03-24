
//#-hidden-code
import PlaygroundSupport
import SpriteKit

func writeLetter(_ message: String){
    
    let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 640))
    if let scene = HashScene(fileNamed: "HashScene") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        sceneView.presentScene(scene)
        scene.writeInPaper(message: message)
        scene.fallLetter()
        scene.mailNode?.setNonce(nonceText: "")
//        scene.calculateHash(message)
    }
    
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
    
}

//#-end-hidden-code
/*:
 In Blockchain and in the computer world, **Hash** is a very important concept. As we deal with different kinds and sizes of data, sometimes we need to summarize it. Hash has this exact goal.
 Let`s imagine you need to write a letter to someone, but when you pack your letter within the envelope, it magically summarize your letter content in a 10-digit sequence. This number depends directly on the content you wrote your message, is equivalent to the hash of your message, and has these properties
 
 The most interesting thing is: no matter if your message has a single word, a paragraph or an entire book content, the output will always have ten digits.
 
 ![Hash demonstration](hashDemo@3x.png)
 
 The message is written in the paper on the top and then it is packed generating the hash in the envelope
 
 **Goal:** Write different messages to the **message** variable to check the hash result in the envelope format.
 
 **Try:**
 - Write a message that contains only a single word
 - Write a message that consists on a simple phrase
 - Remove a single letter from the last message you wrote and verify how the resumes are different and observe how different the result is from the original paragraph
 */

//#-editable-code
let message = "WWDC 2019"
//#-end-editable-code

//#-hidden-code
writeLetter(message)
//#-end-hidden-code

