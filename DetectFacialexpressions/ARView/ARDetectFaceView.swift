//
//  ARDetectFaceView.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/06.
//

import UIKit
import RealityKit
import ARKit
import Combine

class ARDetectFaceView: UIView {
    
    // MARK: Properties
    
    let arView = ARView(frame: UIScreen.main.bounds)
    let faceAnchor = AnchorEntity()

    var selectedVirtualContent: MenuItem {
        didSet {
            faceAnchor.removeAllChildren()
            arView.session.run(ARFaceTrackingConfiguration(), options: [.removeExistingAnchors, .resetTracking])
        }
    }
    var selectedContentController: VirtualContentController {
        return selectedVirtualContent.makeController()
    }
    
    var menuInfo: MenuInfo
    var menuInfoTask: AnyCancellable?
    
    init(frame frameRect: CGRect,_ menuInfo: MenuInfo) {
        // Check if ARBodyTrackingConfiguration is supported
        guard ARBodyTrackingConfiguration.isSupported else {
            fatalError("This feature is only supported on devices with an A12 chip")
        }
        
        self.menuInfo = menuInfo
        self.selectedVirtualContent = self.menuInfo.menuItem
        
        
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
        
        // ゲーム情報の受け取りタスク
        self.menuInfoTask = menuInfo.$menuItem.receive(on: DispatchQueue.main).sink { (value) in
            self.selectedVirtualContent = value
        }
        
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
