//
//  ViewController.swift
//  Example
//
//  Created by Scott Moon on 28/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCReviewRatingKit

class ViewController: UIViewController {

  lazy var reviewStarView: SCReviewRatingView = {
    let view = SCReviewRatingView()
    view.isOpaque = true
    view.backgroundColor = .clear
    view.tintColor = .red
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    view.addSubview(reviewStarView)

    reviewStarView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      reviewStarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      reviewStarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      reviewStarView.widthAnchor.constraint(equalToConstant: 200),
      reviewStarView.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
