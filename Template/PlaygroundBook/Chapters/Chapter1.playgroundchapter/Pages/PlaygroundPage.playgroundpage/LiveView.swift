//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//

import PlaygroundSupport
import SpriteKit

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 640))
if let scene = HashScene(fileNamed: "HashScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
    scene.mailNode!.initializeHashLabel()
//    scene.changeHashLabel("Here is the letter resume", UIColor.blue)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//The playground`s idea is to illustrate some Blockchain concepts to the user. In the first scene we show an enveloped letter with a number in its outside, and the user must write some message to send to the post office. Try writing something inside de calculate hash function, and then you can see each differect message produces a completely different number to the envelope. Now, erase a single charactere of your message and check the result.The generated number is completely different to the previous letter. As you can see, the number in the front represents a small resume of what you are writing. In computer science, this concept is called hash.


