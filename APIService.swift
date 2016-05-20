//
//  APIService.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/14/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

import UIKit
import Alamofire
import SHUtil
import SwiftyJSON
import Bond

enum RequestState :UInt {
    case None = 0
    case Requesting
    case Error
}

enum Router: URLRequestConvertible {
    static let host         = Config.plist("baseURL")
    static let version      = Config.plist("apiVersion")
    static let apiBaseURL   = "\(Router.host)/api/\(Router.version)"
    
    case test()
    case CreateUser([String: AnyObject])
    case GetAllNotices()
    case GetNoticeWithCampusId(campusId: String)
    case GetNoticeWithNoticeId(noticeId: String)
    case GetAllLectures()
    case GetLectureWithCampusId(campusId: String)
    case GetLectureWithLectureId(lectureId: String)
    case GetAllAccesses()
    case GetAccessWithCampusId(campusId: String)
    case GetAccessWithAccessId(accessId: String)
    case GetCalendar(campusId: String)
    var method: Alamofire.Method {
        switch self {
        case .test:                     return .GET
        case .CreateUser:               return .POST
        case .GetAllNotices:            return .GET
        case .GetNoticeWithCampusId:    return .GET
        case .GetNoticeWithNoticeId:    return .GET
        case GetAllLectures:            return .GET
        case GetLectureWithCampusId:    return .GET
        case GetLectureWithLectureId:   return .GET
        case GetAllAccesses:            return .GET
        case GetAccessWithCampusId:     return .GET
        case GetAccessWithAccessId:     return .GET
        case GetCalendar:               return .GET
        }
    }
    var path: String {
        switch self {
        case test: return ""
        case CreateUser:                                return "/users"
        case GetAllNotices():                           return "/notices"
        case GetNoticeWithCampusId(_):                  return "/notices"
        case GetNoticeWithNoticeId(let noticeId):       return "/notice/\(noticeId)"
        case GetAllLectures():                          return "/lectures"
        case GetLectureWithCampusId(_):      return "/lectures"
        case GetLectureWithLectureId(let lectureId):    return "/lecture/\(lectureId)"
        case GetAllAccesses():                          return "/accesses"
        case GetAccessWithCampusId(_):       return "/accesses"
        case GetAccessWithAccessId(let accessId):       return "/access/\(accessId)"
        case GetCalendar:                               return "/calender/"
        }
    }
    // MARK: URLRequestConvertible
    var URLRequest: NSMutableURLRequest {
//        let URL               = NSURL(string: Router.apiBaseURL)!
        let URL               = NSURL(string: "https://qiita.com")!
//        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent("/api/v2/items"))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        //        if let token = Router.OAuthToken {
        //            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //        }
        
        switch self {
            //        case .CreateUser(let parameters):
        //            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .GetNoticeWithCampusId(let campusId):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["campus_id":campusId]).0
//        case .GetLectureWithCampusId(let campusId):
//            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["campus_id":campusId,"server_time":Config.userDefault.isUpdateLectureTime()]).0
        case .GetAccessWithCampusId(let campusId):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["campus_id":campusId]).0
        default:
            return mutableURLRequest
        }
    }
    
}


struct APIService {
    static func test(completionHandler: (ObservableArray<Note.ObservableNote>) -> (), errorHandler: (ErrorType?,Int) -> ()) -> () {
        Alamofire.request(Router.test()).responseSwiftyJSON({(request,response,jsonData,error) in
            guard let res = response else {
                SHprint("error! no response")
                return
            }
            if res.statusCode < 200 && res.statusCode >= 300 {
                SHprint("error!! status => \(res.statusCode)")
                return
            }
            
            let arr = ObservableArray<Note.ObservableNote>()
            
            for (_, subJson) in jsonData {
                
                let feed = Note.ObservableNote(title: subJson["title"].string,
                    
                    username: subJson["user"]["id"].string,
                    
                    userImageURL: subJson["user"]["profile_image_url"].string,
                    
                    url: subJson["url"].string
                    
                )
                
                arr.append(feed)
                
            }
            
            completionHandler(arr)
        })
    }

//    static func reqestNotices(campus: Int,completionHandler: ([Notice]) -> (), errorHandler: (ErrorType?,Int) -> ()) -> () {
//        Alamofire.request(Router.GetNoticeWithCampusId(campusId: String(campus))).responseSwiftyJSON({(request,response,jsonData,error) in
//            guard let res = response else {
//                SHprint("error! no response")
//                return
//            }
//            if res.statusCode < 200 && res.statusCode >= 300 {
//                SHprint("error!! status => \(res.statusCode)")
//                return
//            }
//            var arr: [Notice] = []
//            for (_,json) in jsonData {
//                arr.append(Notice(json: json))
//            }
//            completionHandler(arr)
//        })
//    }
//    
//    static func reqestNotice(noticeId: String ,campus: Int,completionHandler: (Notice) -> (), errorHandler: (ErrorType?,Int) -> ()) -> () {
//        Alamofire.request(Router.GetNoticeWithNoticeId(noticeId: noticeId)).responseSwiftyJSON({(request,response,jsonData,error) in
//            guard let res = response else {
//                SHprint("error! no response")
//                return
//            }
//            if res.statusCode < 200 && res.statusCode >= 300 {
//                SHprint("error!! status => \(res.statusCode)")
//                return
//            }
//            //            SHprint(jsonData)
//            completionHandler(Notice(json: jsonData))
//        })
//    }
//    
//    static func reqestLectures(campus: Int,completionHandler: ([Lecture]) -> (), errorHandler: (ErrorType?,Int) -> ()) -> () {
//        Alamofire.request(Router.GetLectureWithCampusId(campusId: String(campus))).responseSwiftyJSON({(request,response,jsonData,error) in
//            guard let res = response else {
//                SHprint("error! no response")
//                return
//            }
//            if res.statusCode < 200 && res.statusCode >= 300 {
//                SHprint("error!! status => \(res.statusCode)")
//                return
//            }
//            var arr: [Lecture] = []
//            //            SHprint(jsonData)
//            for (_,json) in jsonData["data"] {
//                arr.append(Lecture(json: json))
//            }
//            //            SHprint(jsonData["server_time"])
//            NSUserDefaults.standardUserDefaults().setObject(String(jsonData["server_time"]), forKey: Config.userDefault.getLectureKey())
//            completionHandler(arr)
//        })
//    }
//    
//    static func reqestAccesses(campus: Int,completionHandler: ([Access]) -> (), errorHandler: (ErrorType?,Int) -> ()) -> () {
//        Alamofire.request(Router.GetAccessWithCampusId(campusId: String(campus))).responseSwiftyJSON({(request,response,jsonData,error) in
//            guard let res = response else {
//                SHprint("error! no response")
//                return
//            }
//            if res.statusCode < 200 && res.statusCode >= 300 {
//                SHprint("error!! status => \(res.statusCode)")
//                return
//            }
//            var arr: [Access] = []
//            for (_,json) in jsonData {
//                arr.append(Access(json: json))
//            }
//            completionHandler(arr)
//        })
//    }
    
}
