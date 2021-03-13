//
//  DetectFacePieyonController.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/09.
//

import ARKit
import RealityKit

class DetectFacePieyonController: NSObject, VirtualContentController {
    
    private var originalMouthTopZ: Float = 0
    private var originalMouthUnderZ: Float = 0
    
    func updateObject(_ session: ARSession,_ anchors: [ARAnchor],_ parentAnchorEntity : Entity) {
        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor
                else { return }
            
            let blendShapes = faceAnchor.blendShapes
            
            // これしか思いつかなかった。。。
            if originalMouthTopZ == 0 {
                originalMouthTopZ = 0.02699686
                originalMouthUnderZ = 0.053223185
            }
            
            guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
                let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float,
                let mouthFunnel = blendShapes[.mouthFunnel] as? Float
                else { return }
            
            pieyonObject.eyeLeft!.scale.y = (1 - eyeBlinkLeft) * 0.2
            pieyonObject.eyeRight!.scale.y = (1 - eyeBlinkRight) * 0.2
            
            pieyonObject.mouthTop!.position.z = (originalMouthTopZ - (pieyonObject.mouthTop!.position.z * mouthFunnel))
            pieyonObject.mouthUnder!.position.z = (originalMouthUnderZ + (pieyonObject.mouthUnder!.position.z * mouthFunnel))
            
            
            parentAnchorEntity.addChild(pieyonObject)
            
        }
    }
}
