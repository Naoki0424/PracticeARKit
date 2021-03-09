//
//  DetectFacePieyonController.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/09.
//

import ARKit
import RealityKit

class DetectFacePieyonController: NSObject, VirtualContentController {
    
    func updateObject(_ session: ARSession,_ anchors: [ARAnchor],_ parentAnchorEntity : Entity) {
        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor
                else { return }
            
            let blendShapes = faceAnchor.blendShapes
            
            guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
                let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float,
                let mouthRollUpper = blendShapes[.mouthRollUpper] as? Float,
                let mouthRollLower = blendShapes[.mouthRollLower] as? Float
                else { return }
            
            print("eyeBlinkLeft:", eyeBlinkLeft)
            print("eyeBlinkRight:", eyeBlinkRight)
            print("mouthRollUpper:", mouthRollUpper)
            print("mouthRollLower:", mouthRollLower)
            
            
//            pieyonObject.eyeLeft
//            pieyonObject.eyeRight
//
//            pieyonObject.mouthRollUpper
//            pieyonObject.mouthRollLower
            
            parentAnchorEntity.addChild(pieyonObject)
            
        }
    }
    
    func addObject(_ entity: Entity, _ parentAnchorEntity: Entity) {
        parentAnchorEntity.removeAllChildren()
        if parentAnchorEntity.children.count == 0 {
            parentAnchorEntity.addChild(entity)
        }
    }
}
