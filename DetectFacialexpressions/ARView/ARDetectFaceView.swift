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
    var brightFaceObject: MyScene.FaceBright!
    var defaultFaceObject: MyScene.FaceDefault!
    var defaultTongueObject: MyScene.Tongue!
    var pieyonObject: MyScene.Pieyon!
    
//    var defaultPosition: SIMD3<Float>!
//    var defaultScale: SIMD3<Float>!
    
    
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
        
        setupFaceTracking()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFaceTracking() {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        // Set a Anchor（Objects can be placed on top of the anchor）
        // Place the object when the body is detected
        arView.scene.addAnchor(faceAnchor)
        
        // Read a 3D Object
        brightFaceObject = try! MyScene.loadFaceBright()
        defaultFaceObject = try! MyScene.loadFaceDefault()
        defaultTongueObject = try! MyScene.loadTongue()
        pieyonObject = try! MyScene.loadPieyon()
//        defaultPosition = brightFaceObject.position
//        defaultScale = brightFaceObject.scale
        
    }

}

//MARK:- Session

extension ARDetectFaceView: ARSessionDelegate{
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            // Processing is interrupted.
            // When other than ARFaceAnchor is detected.
            guard let detectedAnchor = anchor as? ARFaceAnchor else {return}
            
            // Get blendShapes(BlendShapes include vatious infomation)
            let blendShapes = detectedAnchor.blendShapes
            
            guard let jawOpen = blendShapes[.jawOpen] as? Float,
                  let tongueOut = blendShapes[.tongueOut] as? Float else { return }

            let jawOpenAfterTruncation = jawOpen.floorSecondDecimalPlace()
            
            addObject(pieyonObject)
            
//            if tongueOut > 0.5 {
//                addObject(defaultTongueObject)
//            }else if jawOpenAfterTruncation > 0.5 {
//                addObject(brightFaceObject)
//            }else {
//                addObject(defaultFaceObject)
//            }
        }
    }
    
    func addObject(_ entity: Entity) {
        faceAnchor.removeAllChildren()
        if faceAnchor.children.count == 0 {
            faceAnchor.addChild(entity)
        }
    }
    
}
