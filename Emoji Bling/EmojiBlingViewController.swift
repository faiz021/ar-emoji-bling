//
//  ViewController.swift
//  Emoji Bling
//
//  Created by faiz mohideen on 11/07/2019.
//  Copyright © 2019 faiz mohideen. All rights reserved.
//

// Following: https://www.raywenderlich.com/5491-ar-face-tracking-tutorial-for-ios-getting-started#toc-anchor-003

import UIKit
import ARKit

class EmojiBlingViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking is not supported on this device")
        }
        sceneView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}

extension EmojiBlingViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else {  return nil }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
        }
        faceGeometry.update(from: faceAnchor.geometry)
    }
}
