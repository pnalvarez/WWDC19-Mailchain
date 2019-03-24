
//#-hidden-code
import PlaygroundSupport
import SpriteKit

func writeLetterWithDifficulty(message: String, difficulty: UInt){
    
    let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 640))
    if let scene = MineScene(fileNamed: "MineScene") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        sceneView.presentScene(scene)
        scene.difficulty = difficulty
        scene.writeInPaper(message: message)
        scene.fallLetter()
//        scene.canInteract = true

//        scene.difficulty = difficulty
        
    }
    
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}

//#-end-hidden-code
/*:
   But this post office you are sending your message has some restrictions with the
 messages they send: The letters hash must have some zeros on its preffix, but you don`t want to modify the letter you sent. So, there is a number that is combined with your message to generate a summarize(hash) that has such zeros
 
 ![Nonce hash](nonceDemo@3x.png)
 
 - The number of zeros that will compose the hash preffix must be defined by you, and this number is known as the difficulty, the greater is this number, bigger is the difficulty to find the hash that has it as preffix.
-  The nonce starts as zero and is incremented by one until find the hash that matches the restriction
 
 ![Diagram](miningDiagram@3x.png)

 
 
 **Goal:** Write a message in the ``message`` [variable](glossary://variable)  to generate a hash and also give a difficulty as input to be the number of zeros the hash preffix will have
 
 
  Tap the ![Mine](mineMarkUp@3x.png) button to start the mining task
 
 **Note:** If you choose a difficulty equal or greater than 3, the mining task may take a long time
 
 
 */
//#-editable-code
let message = "WWDC 2019"
let difficulty = 1
//#-end-editable-code


//#-hidden-code
writeLetterWithDifficulty(message: message, difficulty: UInt(difficulty))
//#-end-hidden-code
