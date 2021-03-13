//
//  DetectFaceMusicNotesController.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/11.
//

import ARKit
import RealityKit

class DetectFaceMusicNotesController: NSObject, VirtualContentController {
    func updateObject(_ session: ARSession,_ anchors: [ARAnchor],_ parentAnchorEntity : Entity) {
        for anchor in anchors {
            // Processing is interrupted.
            // When other than ARFaceAnchor is detected.
            guard let detectedAnchor = anchor as? ARFaceAnchor else {return}
            // Get blendShapes(BlendShapes include vatious infomation)
            let blendShapes = detectedAnchor.blendShapes
            
            guard let jawOpen = blendShapes[.jawOpen] as? Float else { return }
            
            if jawOpen.floorSecondDecimalPlace() > 0.5 {
                parentAnchorEntity.addChild(musicNotesObject)
            }else {
                parentAnchorEntity.removeAllChildren()
            }
        }
    }
}

