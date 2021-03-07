//
//  ARDetectFaceView.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/06.
//

import UIKit
import RealityKit
import ARKit

class ARDetectFaceView: UIView {
    // ARView
    let arView = ARView(frame: UIScreen.main.bounds)
    
    // サインボード宣言
    let faceAnchor = AnchorEntity()
    var brightFaceObject: Experience.faceBright!
    
    
    init(frame frameRect: CGRect) {
        // Check if ARBodyTrackingConfiguration is supported
        guard ARBodyTrackingConfiguration.isSupported else {
            fatalError("This feature is only supported on devices with an A12 chip")
        }
        
        // Init parent Object
        super.init(frame: frameRect)
        
        // Register a delegate
        arView.session.delegate = self
        
        // Add a ARView
        addSubview(arView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- Session

extension ARDetectFaceView: ARSessionDelegate{
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let detectedAnchor = anchor as? ARFaceAnchor else {return}
        }
    }
    
}
