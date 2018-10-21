//
//  LocationManager.swift
//  jpHacks2018-team-toralab
//
//  Created by tomonori takada on 2018/10/17.
//  Copyright © 2018年 jpHacks2018-team-toralab. All rights reserved.
//

import Foundation
import CoreLocation

//現在地取得用クラス
class LocationManager : NSObject,CLLocationManagerDelegate{
    static private var mIns:LocationManager!
    static private var mLocationManager:CLLocationManager!
    //オブザーバ
    static private var mUpdateLocationObserver:[((CLLocationCoordinate2D)->(),String)]!
    //現在地座標
    static private(set) var longitude: CLLocationDegrees!
    static private(set) var latitude: CLLocationDegrees!
    //現在地情報更新開始
    static func start(){
        if(mIns != nil){return}
        mUpdateLocationObserver=[]
        mIns=LocationManager()
        mLocationManager=CLLocationManager()
        mLocationManager.delegate=mIns
        mLocationManager.startUpdatingLocation()
    }
    //現在地情報を取得(取得が完了していない場合は、取得完了してからcallback)
    static func getLocation(_ aFunction:@escaping (CLLocationCoordinate2D)->()){
        if(longitude != nil && latitude != nil){
            aFunction(CLLocationCoordinate2DMake(longitude,latitude))
            return
        }
        let tKey="GetFirstLocation"
        setUpdateLocationObserver({a in
            removeUpdateLocationObserver(tKey)
            aFunction(a)
        }, tKey)
    }
    //現在地情報取得成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        LocationManager.longitude=locations[0].coordinate.longitude
        LocationManager.latitude=locations[0].coordinate.latitude
        LocationManager.notifyUpdateLocation()
    }
    //現在地更新オブザーバ追加
    static func setUpdateLocationObserver(_ aFunction:@escaping (CLLocationCoordinate2D)->(),
                                          _ aName:String=""){
        mUpdateLocationObserver.append((aFunction,aName))
    }
    //現在地更新オブザーバ削除
    static func removeUpdateLocationObserver(_ aName:String){
        for i in 0..<mUpdateLocationObserver.count{
            let tObserver=mUpdateLocationObserver[i]
            if(tObserver.1 != aName){continue}
            mUpdateLocationObserver.remove(at: i)
            return
        }
    }
    //オブザーバ呼び出し
    private static func notifyUpdateLocation(){
        let tObserverList=mUpdateLocationObserver!
        for tObserver in tObserverList{
            tObserver.0(CLLocationCoordinate2DMake(latitude,longitude))
        }
    }
}


extension CLLocationCoordinate2D{
    //Dictionaryへの変換
    func toDic()->Dictionary<String,Float>{
        var tDic=Dictionary<String,Float>()
        tDic["longitude"]=Float(longitude)
        tDic["latitude"]=Float(latitude)
        return tDic
    }
    //Dictionaryから変換
    static func convertFrom(_ aDic:Dictionary<String,Float>)->CLLocationCoordinate2D{
        return CLLocationCoordinate2DMake(CLLocationDegrees(aDic["latitude"]!), CLLocationDegrees(aDic["longitude"]!))
    }
}
