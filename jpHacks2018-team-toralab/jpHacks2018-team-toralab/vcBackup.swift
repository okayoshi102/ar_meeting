////
////  ViewController.swift
////  jpHacks2018-team-toralab
////
////  Created by tomonori takada on 2018/10/16.
////  Copyright © 2018年 jpHacks2018-team-toralab. All rights reserved.
////
//
//import UIKit
//import SceneKit
//import ARKit
//import GoogleMaps
//
//class ViewController: UIViewController, ARSCNViewDelegate {
//    
//    @IBOutlet var sceneView: ARSCNView!
//    
//    var mMapView:MyGMapView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set the view's delegate
//        sceneView.delegate = self
//        
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//        
//        // Create a new scene
//        let scene = SCNScene()
//        
//        // Set the scene to the view
//        sceneView.scene = scene
//        
//        ////////////////////////
//        
//        //API Key 設定
//        GMSServices.provideAPIKey(gGoogleMapsApiKey)
//        //現在地取得開始
//        LocationManager.start()
//        
//        //        mMapView=MyGMapView(aRect:CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height),aView:self.view,aCallback:{
//        //            //サーバに接続
//        //            SocketClient.connect()
//        //            //タップイベント設定
//        //            var tTapGesture=UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
//        //            self.view.addGestureRecognizer(tTapGesture)
//        //            tTapGesture=UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
//        //            let tTapView=SCNView()
//        //            tTapView.backgroundColor=UIColor.white
//        //            tTapView.frame=CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
//        //            self.mMapView.mMap.addSubview(tTapView)
//        //            tTapView.addGestureRecognizer(tTapGesture)
//        //        })
//        //
//        //サーバに接続
//        SocketClient.connect()
//        //map表示完了後
//        SocketClient.setUpdateDestinationObserver({aLocation in
//            self.mMapView.mMarkerManager.updateMarker(aLocation, "destination")
//        }, "updateDestination")
//    }
//    
//    @objc func tapped(_ gestureRecognize: UIGestureRecognizer){
//        if(mMapView.mShowingFlag){mMapView.hide()}
//        else{mMapView.show()}
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        // Create a session configuration
//        let configuration = ARWorldTrackingConfiguration()
//        
//        // Run the view's session
//        sceneView.session.run(configuration)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        // Pause the view's session
//        sceneView.session.pause()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }
//    
//    // MARK: - ARSCNViewDelegate
//    
//    /*
//     // Override to create and configure nodes for anchors added to the view's session.
//     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//     let node = SCNNode()
//     
//     return node
//     }
//     */
//    
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//        
//    }
//    
//    func sessionWasInterrupted(_ session: ARSession) {
//        // Inform the user that the session has been interrupted, for example, by presenting an overlay
//        
//    }
//    
//    func sessionInterruptionEnded(_ session: ARSession) {
//        // Reset tracking and/or remove existing anchors if consistent tracking is required
//        
//    }
//}
