//
//  BlogViewPresenter.swift
//  App
//
//  Created by kila on 16/02/2018.
//  Copyright © 2018 kila. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class BlogViewPresenter: NSObject {
    
    let viewProtocol: BlogViewProtocol?
    
    // 构造函数
    init(viewProtocol: BlogViewProtocol) {
        self.viewProtocol = viewProtocol
    }
    
    /* 业务逻辑处理 */
    
    // 下拉刷新
    func refresh(){
        let pageIndex = viewProtocol?.getPageIndex()
        let pageSize = viewProtocol?.getPageSize()
        let userID = ""
        BlogService.list(pageIndex: pageIndex!, pageSize: pageSize!, userID: userID, callback:{(data: Any) -> Void in
            let json = JSON(data)
            let jsonArray = json.arrayValue
            var list = [Blog]()
            for raw in jsonArray{
                let blog = Blog(JSONString: raw.rawString()!)
                blog?.user = User(JSONString: raw.rawString()!)
                list.append(blog!)
            }
            self.viewProtocol?.refresh(list: list)
        })
    }
    
    // 上拉加载
    func load(){
        let pageIndex = viewProtocol?.getPageIndex()
        let pageSize = viewProtocol?.getPageSize()
        let userID = ""
        BlogService.list(pageIndex: pageIndex!, pageSize: pageSize!, userID: userID, callback:{(data: Any) -> Void in
            let json = JSON(data)
            let jsonArray = json.arrayValue
            var list = [Blog]()
            for raw in jsonArray{
                let blog = Blog(JSONString: raw.rawString()!)
                blog?.user = User(JSONString: raw.rawString()!)
                list.append(blog!)
            }
            self.viewProtocol?.load(list: list)
        })
    }
}
