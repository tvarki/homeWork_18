//
//  MyThirdClass.swift
//  homeWork_18
//
//  Created by Дмитрий Яковлев on 02.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation


class MyThirdClass<T:Numeric>{
    var myArray :[T] = [0,1,2,3,4,5,6,7,8,9]
    var lock = NSLock()
    let dispatchGroup = DispatchGroup()
    
    func start(){
        
        let semaphore = DispatchSemaphore(value: 5)
        
        for i in 0 ... self.myArray.count - 1 {
            dispatchGroup.enter()
            DispatchQueue.global().async() {
                
                semaphore.wait()
                self.getResult(index: i, type: T.self)
                semaphore.signal()
                self.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            var res: T = 0
            self.myArray.forEach{
//                print($0)
                res += $0 }
            print( "MyThirdClass Result: \(res)")
        }
    }
    
    
    
    func getResult<T:Numeric>(index : Int, type: T.Type){
        let tmp = self.myArray[index]*self.myArray[index]
        self.lock.lock()
        self.myArray[index] = tmp
        self.lock.unlock()
    }
}
