//
//  MarkerManager.swift
//  jpHacks2018-team-toralab
//
//  Created by tomonori takada on 2018/10/17.
//  Copyright © 2018年 jpHacks2018-team-toralab. All rights reserved.
//

import Foundation
import GoogleMaps

//GoogleMapに表示するマーカーの管理
class MarkerManager{
    //マーカーを表示するmap
    let mTargetMap:GMSMapView
    //表示しているマーカー
    private var mMarkers:[(GMSMarker,String)]
    init(_ aTargetMap:GMSMapView){
        mTargetMap=aTargetMap
        mMarkers=[]
    }
    //マーカーを置く
    func placeMarker(_ aMarker:GMSMarker,_ aName:String=""){
        aMarker.map=mTargetMap
        mMarkers.append((aMarker,aName))
    }
    //マーカーを削除
    func removeMarker(_ aName:String){
        for i in 0..<mMarkers.count{
            let tMarker=mMarkers[i]
            if(tMarker.1 != aName){continue}
            tMarker.0.map=nil
            mMarkers.remove(at: i)
            return
        }
    }
    //マーカーを更新(存在しないマーカーなら新たに生成)
    func updateMarker(_ aLocation:CLLocationCoordinate2D,_ aName:String){
        for i in 0..<mMarkers.count{
            let tMarker=mMarkers[i]
            if(tMarker.1 != aName){continue}
            tMarker.0.position=aLocation
            return
        }
        //マーカーを新たに生成
        let marker: GMSMarker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(aLocation.latitude, aLocation.longitude)
        marker.map=mTargetMap
        mMarkers.append((marker,aName))
    }
}
