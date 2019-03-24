import Foundation
import Spritekit
import PlaygroundSupport

// Load the SKScene from 'GameScene.sks'

public class HashSetUp{

public static func makeScene(){
    
    let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 640))
    if let scene = HashScene(fileNamed: "HashScene") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        sceneView.presentScene(scene)
        scene.changeHashLabel("Here is the letter resume", UIColor.blue)
    }
    
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
 }
}
