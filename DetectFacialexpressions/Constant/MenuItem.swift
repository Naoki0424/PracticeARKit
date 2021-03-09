//
//  MenuItem.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/07.
//

import ARKit
import RealityKit

enum MenuItem: String, CaseIterable {
    case detectFace = "顔検出"
    case pieyon = "ピエよん"
    case test2 = "test2"
    case test3 = "test3"
    case test4 = "test4"
    
    func makeController() -> VirtualContentController {
        switch self {
        case .detectFace:
            return DetectFaceController()
        case .pieyon:
            return DetectFacePieyonController()
        case .test2:
            return DetectFaceController()
        case .test3:
            return DetectFaceController()
        case .test4:
            return DetectFaceController()
        }
    }
}

protocol VirtualContentController{
    func updateObject(_ session: ARSession,_ anchors: [ARAnchor], _ parentAnchorEntity: Entity)
}

final class MenuInfo: ObservableObject {
    @Published var menuItem: MenuItem = .detectFace
}

