//
//  ViewController.swift
//  moyanew
//
//  Created by cey on 2017/9/22.
//  Copyright © 2017年 cey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func fetPublicprojectid(){
       
        let myurl="getProjectById"
        MoyaNetWorkingTools.shareMoyaNetWorkingTools().getDatawithget(nil, url: myurl, isToken: true) { (data, error) -> () in
            if data==nil {
               
                return
            }
            let senddict:NSDictionary=data as! NSDictionary
            let success:String=String(senddict["code"])
            printhidden(senddict as AnyObject)
            if success=="0" {
                
            }else{
              
         
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

