//
//  MySecondClass.swift
//  homeWork_18
//
//  Created by Дмитрий Яковлев on 31.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation





class MySecondClass<T:Numeric>{
    
    var myArray :[T] = [0,1,2,3,4,5,6,7,8,9]
    
    init(){
    }
    
    var lock = NSLock()
    
    func start(){
        let dispatchGroup = DispatchGroup()

        for i in 0...self.myArray.count - 1{
            dispatchGroup.enter()
            DispatchQueue.global().async() {
//                print(i)
                self.getResult(index: i, type: T.self)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            var res: T = 0
            self.myArray.forEach{ res += $0 }
            print( "MyFirstClass Result: \(res)")
        }
    }
    
    func getResult<T:Numeric>(index : Int, type: T.Type){
        let tmp = self.myArray[index]*self.myArray[index]
        self.lock.lock()
        self.myArray[index] = tmp
        self.lock.unlock()
    }
    
}
