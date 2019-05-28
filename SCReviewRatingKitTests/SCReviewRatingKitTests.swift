//
//  SCReviewRatingKitTests.swift
//  SCReviewRatingKitTests
//
//  Created by Scott Moon on 28/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import XCTest
@testable import SCReviewRatingKit

class SCReviewRatingKitTests: XCTestCase {

  var sut: SCReviewRatingView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = SCReviewRatingView(frame: .zero)
    XCTAssertNotNil(sut)
  }
}
