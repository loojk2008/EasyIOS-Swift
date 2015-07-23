//
//  MainScene.swift
//  Demo
//
//  Created by zhuchao on 15/5/13.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation

import Bond
import EasyIOS


class MainScene: EUScene,UITableViewDelegate{
    var sceneModel = MainSceneModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EasyIOS"

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //do someThing init before loadTheView
    override func eu_viewWillLoad() {
        self.attributedLabelDelegate = MainLabelDeleage()
    }
    
    override func eu_tableViewDidLoad(tableView:UITableView?){
        
        tableView?.delegate = self
        
        //定义一个可以给JS调用的下拉刷新回调方法handlePullRefresh()
        document.define("handlePullRefresh"){
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(3.0 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                tableView?.pullToRefreshView?.stopAnimating()
            }
        }
        
        let section1 = self.sceneModel.dataArray.map{ (data:NSObject) -> UITableViewCell in
            let cell = tableView!.dequeueReusableCell("cell", target: self,bind:data) as UITableViewCell
            cell.selectionStyle = .None
            return cell
        }
        DynamicArray([section1,section1,section1]) ->> self.eu_tableViewDataSource!
    }

    //xml里已经有了tap点击事件，这里就不调用了
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var model = self.sceneModel.dataArray[indexPath.row]
//        if let link = model.link {
//            URLManager.pushURLString(link, animated: true)
//        }
//    }
    

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView
        return tableView.getSectionViewByTagId("bgView", target: self,bind:sceneModel.sectionArray[section])
    }
    
    
}
