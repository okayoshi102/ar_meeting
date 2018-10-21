//
//  File.swift
//  jpHacks2018-team-toralab
//
//  Created by tomonori takada on 2018/10/21.
//  Copyright © 2018年 jpHacks2018-team-toralab. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MyGMapView{
    private(set) var mMarkerManager:MarkerManager!
    private var mView:UIView
    private(set) var mMap:MyGMap!
    private(set) var mShowingFlag:Bool=false
    init(aRect:CGRect,aView:UIView,aCallback:@escaping ()->()={}) {
        mView=aView
        //起動時の位置を取得
        LocationManager.getLocation({aLocation in
            self.mMap=MyGMap(aFrame: aRect, aLocation: aLocation)
            self.mMarkerManager=MarkerManager(self.mMap)
            //viewにMapViewを追加
//            self.show()
            
            //自分のマーカー作成
            let marker: GMSMarker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(aLocation.latitude, aLocation.longitude)
            marker.snippet="あなた"
            self.mMarkerManager!.placeMarker(marker,"mine")
            //現在地表示
            self.mMap.isMyLocationEnabled=true
            //自分の位置が更新されるたびにマーカーの位置を更新
            LocationManager.setUpdateLocationObserver({aPosition in
                marker.position=aPosition
            }, "updateMarkerLocation")
            aCallback()
        })
    }
    func show(){
        if(mShowingFlag){return}
        mShowingFlag=true
        mView.addSubview(mMap)
    }
    func hide(){
        if(!mShowingFlag){return}
        mShowingFlag=false
        mMap.removeFromSuperview()
    }
}
