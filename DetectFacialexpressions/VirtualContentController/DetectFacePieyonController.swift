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
            // Processing is interrupted.
            // When other than ARFaceAnchor is detected.
//            guard let detectedAnchor = anchor as? ARFaceAnchor else {return}
            guard anchor is ARFaceAnchor else {return}
            
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
