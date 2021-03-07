//
//  CommonEntity.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/06.
//

import RealityKit

extension Entity {
    func removeAllChildren() {
        for entity in self.children {
            entity.removeFromParent()
        }
    }
}
