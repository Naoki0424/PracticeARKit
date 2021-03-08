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
    
    // MARK: Properties
    
    let arView = ARView(frame: UIScreen.main.bounds)
    let faceAnchor = AnchorEntity()

    var selectedVirtualContent: MenuItem = .detectFace {
        didSet {
            arView.session.run(ARFaceTrackingConfiguration(), options: [.removeExistingAnchors, .resetTracking])
        }
    }
    var selectedContentController: VirtualContentController {
        return selectedVirtualContent.makeController()
    }
    
    override init(frame frameRect: CGRect) {
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
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        // Set a Anchor（Objects can be placed on top of the anchor）
        // Place the object when the body is detected
        arView.scene.addAnchor(faceAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- Session

extension ARDetectFaceView: ARSessionDelegate{
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        selectedContentController.updateObject(session, anchors, faceAnchor)
    }
}
