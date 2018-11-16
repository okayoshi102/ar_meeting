//
//  SocketClient.swift
//  jpHacks2018-team-toralab
//
//  Created by tomonori takada on 2018/10/18.
//  Copyright © 2018年 jpHacks2018-team-toralab. All rights reserved.
//

import Foundation
import SocketIO
import GoogleMaps

class SocketClient{
    static private var mManager:SocketManager!
    static private var mSocket:SocketIOClient!
    //オブザーバ
//    static private var mUpdateLocationObserver:[((CLLocationCoordinate2D,String,String)->(),String)]!=[]
    static private var mUpdateDestinationObserver:[((CLLocationCoordinate2D)->(),String)]!=[]
    //サーバに接続する
    static func connect(){
        mManager=SocketManager(socketURL: URL(string: "https://desolate-coast-58380.herokuapp.com")!, config: [.log(true), .compress])
        mSocket=mManager.defaultSocket
        print("サーバにアクセスしています")
        mSocket.on("connected", callback: {(_,_) in
            print("サーバに接続しました")
        })
        mSocket.on("updateLocation", callback: {(arg,_) in
            print("目的地が更新されました")
            let tArg=(arg[0] as! NSDictionary)
            var tDic=Dictionary<String,Float>()
            tDic["latitude"]=(tArg["latitude"]! as! NSNumber).floatValue
            tDic["longitude"]=(tArg["longitude"]! as! NSNumber).floatValue
            let tLocation=CLLocationCoordinate2D.convertFrom(tDic)
            notifyUpdateDestination(tLocation)
        })
        mSocket.connect()
    }
    //現在地が更新されるたびにサーバに通知する
    static private func setSendChangeLocationEvent(){
        LocationManager.setUpdateLocationObserver({aLocation in
            mSocket.emit("updateLocation", aLocation.toDic())
        }, "sendLocationToServer")
    }

    //目的地更新オブザーバ追加
    static func setUpdateDestinationObserver(_ aFunction:@escaping (CLLocationCoordinate2D)->(),
                                          _ aName:String=""){
        mUpdateDestinationObserver.append((aFunction,aName))
    }
    //目的地更新オブザーバ削除
    static func removeUpdateDestinationObserver(_ aName:String){
        for i in 0..<mUpdateDestinationObserver.count{
            let tObserver=mUpdateDestinationObserver[i]
            if(tObserver.1 != aName){continue}
            mUpdateDestinationObserver.remove(at: i)
            return
        }
    }
    //オブザーバ呼び出し
    private static func notifyUpdateDestination(_ aLocation:CLLocationCoordinate2D){
        let tObserverList=mUpdateDestinationObserver!
        for tObserver in tObserverList{
            tObserver.0(aLocation)
        }
    }
//    //ユーザの座標更新オブザーバ追加
//    static func setUpdateLocationObserver(_ aFunction:@escaping (CLLocationCoordinate2D,String,String)->(),
//                                          _ aName:String=""){
//        mUpdateLocationObserver.append((aFunction,aName))
//    }
//    //ユーザの座標更新オブザーバ削除
//    static func removeUpdateLocationObserver(_ aName:String){
//        for i in 0..<mUpdateLocationObserver.count{
//            let tObserver=mUpdateLocationObserver[i]
//            if(tObserver.1 != aName){continue}
//            mUpdateLocationObserver.remove(at: i)
//            return
//        }
//    }
//    //ユーザの座標更新オブザーバ呼び出し
//    private static func notifyUpdateLocation(_ aLocation:CLLocationCoordinate2D,_ aName:String,_ aKey:String){
//        let tObserverList=mUpdateLocationObserver!
//        for tObserver in tObserverList{
//            tObserver.0(aLocation,aName,aKey)
//        }
//    }
}
