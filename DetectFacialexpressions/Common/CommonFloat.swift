//
//  CommonFloat.swift
//  DetectFacialexpressions
//
//  Created by 角田直樹 on 2021/03/06.
//
import UIKit

extension Float {
    func floorSecondDecimalPlace() -> Float{
        return floor(self * 10) / 10
    }
}
