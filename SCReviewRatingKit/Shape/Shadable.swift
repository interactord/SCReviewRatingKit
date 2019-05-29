//
// Created by Scott Moon on 2019-05-29.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

protocol Shadable {
	func makeShape(frame: CGRect) -> UIBezierPath
}
