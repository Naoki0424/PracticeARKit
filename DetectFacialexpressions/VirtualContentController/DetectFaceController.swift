//
//  DetectFaceController.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/08.
//

import ARKit
import RealityKit

class DetectFaceController: NSObject, VirtualContentController {
    
    func updateObject(_ session: ARSession,_ anchors: [ARAnchor],_ parentAnchorEntity : Entity) {
        for anchor in anchors {
            // Processing is interrupted.
            // When other than ARFaceAnchor is detected.
            guard let detectedAnchor = anchor as? ARFaceAnchor else {return}
            
            // Get blendShapes(BlendShapes include vatious infomation)
            let blendShapes = detectedAnchor.blendShapes
            
            guard let jawOpen = blendShapes[.jawOpen] as? Float,
                  let tongueOut = blendShapes[.tongueOut] as? Float else { return }

            let jawOpenAfterTruncation = jawOpen.floorSecondDecimalPlace()
            
            if tongueOut > 0.5 {
                addObject(faceTongueObject, parentAnchorEntity)
            }else if jawOpenAfterTruncation > 0.5 {
                addObject(brightFaceObject, parentAnchorEntity)
            }else {
                addObject(defaultFaceObject, parentAnchorEntity)
            }
        }
    }
    
    func addObject(_ entity: Entity, _ parentAnchorEntity: Entity) {
        parentAnchorEntity.removeAllChildren()
        if parentAnchorEntity.children.count == 0 {
            parentAnchorEntity.addChild(entity)
        }
    }
}
