//
//  ViewController.swift
//  homeWork_18
//
//  Created by Дмитрий Яковлев on 30.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        run()
        
    }
    
    @IBAction func runClicked(_ sender: UIButton){
        run()
    }
    
    func run(){
        
        DispatchQueue.global().async {
            let m1с = MyFirstClass<Int>()
            m1с.start()
        }
               
        DispatchQueue.global().async {
            let m2c = MySecondClass<Int>()
            m2c.start()
        }
        
        DispatchQueue.global().async {
            let m3c = MyThirdClass<Int>()
            m3c.start()
        }
        
        DispatchQueue.global().async {
            let m4c = MyFourthClass<Int>()
            m4c.start()
        }
        
        DispatchQueue.global().async {
            let m5c = MyFifthClass<Int>()
            m5c.start()
        }
    }
    
    
}

