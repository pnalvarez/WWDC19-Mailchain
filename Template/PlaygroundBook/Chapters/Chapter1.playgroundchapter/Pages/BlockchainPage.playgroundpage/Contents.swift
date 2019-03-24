
//#-hidden-code
import PlaygroundSupport
import SpriteKit

// Load the SKScene from 'GameScene.sks'
func writeLetterOnBlockchainScene(_ message: String, _ difficulty: UInt){
    let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 640))
    if let scene = BlockchainScene(fileNamed: "BlockchainScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    // Present the scene
    sceneView.presentScene(scene)
    scene.difficulty = difficulty
    scene.writeLetter(message: message)
    scene.bringLetter()
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}
//#-end-hidden-code
/*:
The post office you are sending your message wants to keep all the letters they sent recorded as copies in a chain of letters as historic. But they want to avoid anyone chaging the past letter content, each envelope has a reference to the last one which was placed on the chain,and the new letter hash is calculated with the previous one.
 
 ![Hash](prevHashDiagram@3x.png)
 
This is how the Blockchain works, it is a list of blocks containing information within, and when it is going to place a new block, it depends on the previous block`s hash to calculate its content.
 
 ![Blockchain](blocks@3x.png)
 
 **Goal:** Write a message, give a difficulty and run the playground to watch the process of adding a new letter to the chain.
 
 **Tip:** Observe when the envelope meets the letter with your message and calculates shows the previous letter`s hash. It fades in and out to indicate they are linked
 */

//#-editable-code
let message = "WWDC 2019"
let difficulty = 1
//#-end-editable-code

//#-hidden-code
writeLetterOnBlockchainScene(message, UInt(difficulty))
//#-end-hidden-code
