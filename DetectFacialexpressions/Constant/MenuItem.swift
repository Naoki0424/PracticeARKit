//
//  MenuItem.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/07.
//

import ARKit
import RealityKit

enum MenuItem: String, CaseIterable {
    case detectFace = "吹き出し"
    case pieyon = "ピエよん"
    case musicNotes = "音符"
//    case detectTorysImage = "TORYS検出"
//    case test4 = "test4"
    
    func makeController() -> VirtualContentController {
        switch self {
        case .detectFace:
            return DetectFaceController()
        case .pieyon:
            return DetectFacePieyonController()
        case .musicNotes:
            return DetectFaceMusicNotesController()
//        case .detectTorysImage:
//            return DetectTorysController()
//        case .test4:
//            return DetectFaceController()
        }
    }
    
    func initARConfiguration(_ arView: ARView) {
        switch self {
        case .detectFace:
            initARFaceTrackingConfiguration(arView)
        case .pieyon:
            initARFaceTrackingConfiguration(arView)
        case .musicNotes:
            initARFaceTrackingConfiguration(arView)
//        case .detectTorysImage:
//            initARImageTrackingConfiguration(arView)
//        default:
//            initARFaceTrackingConfiguration(arView)
        }
    }
    
    func initARFaceTrackingConfiguration(_ arView: ARView) {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func initARImageTrackingConfiguration(_ arView: ARView) {
        let configuration = ARImageTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { fatalError("Missing expected asset catalog resources.") }
        
        configuration.maximumNumberOfTrackedImages = 1
        configuration.trackingImages = referenceImages
        
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}

protocol VirtualContentController{
    func updateObject(_ session: ARSession,_ anchors: [ARAnchor], _ parentAnchorEntity: Entity)
}

final class MenuInfo: ObservableObject {
    @Published var menuItem: MenuItem = .detectFace
}

