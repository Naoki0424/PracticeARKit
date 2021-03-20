//
//  DetectImageController.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/14.
//

import ARKit
import RealityKit

class DetectTorysController: NSObject, VirtualContentController {
    func updateObject(_ session: ARSession,_ anchors: [ARAnchor],_ parentAnchorEntity : Entity) {
        for anchor in anchors {
            // Processing is interrupted.
            // When other than ARFaceAnchor is detected.
            guard let imageAnchor = anchors.first as? ARImageAnchor
//                  , let _ = imageAnchor.referenceImage.name
            else { return }
            
            print("検出中")
            parentAnchorEntity.addChild(imageObject)
        }
    }
}
