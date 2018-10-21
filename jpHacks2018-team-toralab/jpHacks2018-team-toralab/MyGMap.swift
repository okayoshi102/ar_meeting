//
//  MyMapDrafter.swift
//  jpHacks2018-team-toralab
//
//  Created by tomonori takada on 2018/10/17.
//  Copyright © 2018年 jpHacks2018-team-toralab. All rights reserved.
//

import Foundation
import GoogleMaps

//GoogleMapの拡張
class MyGMap : GMSMapView{
    let mCamera:GMSCameraPosition
    init(aFrame:CGRect,aLocation:CLLocationCoordinate2D,aZoom:Float=15){
        mCamera=GMSCameraPosition.camera(withLatitude: aLocation.latitude, longitude: aLocation.longitude, zoom: aZoom)
        super.init(frame:aFrame)
        self.camera=mCamera
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
