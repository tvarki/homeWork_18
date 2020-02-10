//
//  MyClass.swift
//  homeWork_18
//
//  Created by Дмитрий Яковлев on 30.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation


class MyFirstClass<T:Numeric>{
    var myArray :[T] = [0,1,2,3,4,5,6,7,8,9]
    
    var lock = NSLock()
    var lockArray : [Bool] = []
    var lockArrayLock = NSLock()
    var test = [T]()
    let currentQueue = DispatchQueue(label: "test",attributes: .concurrent)
    
    
    
    init(){
        for _ in 0...myArray.count-1{
            self.lockArray.append(false)
        }
    }
    
    func getResult<T:Numeric>(index : Int, type: T.Type){
        let tmp = self.myArray[index] * self.myArray[index]
        self.lock.lock()
        self.myArray[index] = tmp
        self.lock.unlock()
        
    }
    
    func start(){
        
        let dwi = DispatchWorkItem(qos: .utility){
            var i = 0
            self.lockArrayLock.lock()
            while self.isBysy(index: i){
                i+=1
                guard i < self.lockArray.count else{
                    return
                }
            }
            self.lockArray[i] = true
            self.lockArrayLock.unlock()
            self.getResult(index: i, type: T.self)
            
        }
        
        //        let group = DispatchGroup()
        //        group.notify(queue: currentQueue) {
        //
        //            var tmp2: Bool = true
        //            self.lockArray.forEach{tmp2 = tmp2&&$0}
        //            if tmp2{
        //                var res: T = 0
        //                self.myArray.forEach{ res += $0 }
        //                print( "MySecondClass dwi.notify Result: \(res)")
        //            }
        //            else {
        //                print("Some error in MySecondClass! tmp2 = \(tmp2)")
        //            }
        //        }
        
        
        for _ in 0 ... self.myArray.count - 1 {
//            self.currentQueue.async(group: group, execute: dwi)
            self.currentQueue.async(execute: dwi)
        }
        
        let dispatchWorkItem = DispatchWorkItem( flags: .barrier) {
            var tmp2: Bool = true
            self.lockArray.forEach{tmp2 = tmp2&&$0}
            if tmp2{
                var res: T = 0
                self.myArray.forEach{ res += $0 }
                print( "MySecondClass Result: \(res)")
            }
            else {
                print("Some error in MySecondClass! tmp2 = \(tmp2)")
            }
        }
        self.currentQueue.async(execute: dispatchWorkItem)

    }
    
    func isBysy(index: Int)->Bool{
        if !self.lockArray[index]{
            return false
        }
        return true
    }
    
}
