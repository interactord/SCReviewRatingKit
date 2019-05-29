//
// Created by Scott Moon on 2019-05-29.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct StarShape {
}

extension StarShape: Shadable {
  func makeShape(frame: CGRect) -> UIBezierPath {
    let starShapePath = UIBezierPath()
    starShapePath.move(to: .init(x: frame.minX + 0.627_23 * frame.width, y: frame.minY + 0.373_09 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.500_00 * frame.width, y: frame.minY + 0.025_00 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.372_92 * frame.width, y: frame.minY + 0.373_09 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.025_00 * frame.width, y: frame.minY + 0.391_12 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.305_04 * frame.width, y: frame.minY + 0.629_08 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.206_42 * frame.width, y: frame.minY + 0.975_00 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.500_00 * frame.width, y: frame.minY + 0.782_65 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.793_58 * frame.width, y: frame.minY + 0.975_00 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.695_01 * frame.width, y: frame.minY + 0.629_08 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.975_00 * frame.width, y: frame.minY + 0.391_12 * frame.height))
    starShapePath.addLine(to: .init(x: frame.minX + 0.627_23 * frame.width, y: frame.minY + 0.373_09 * frame.height))
    starShapePath.close()
    starShapePath.miterLimit = 4
    return starShapePath
  }
}
