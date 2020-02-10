//
//  MyFifthClass.swift
//  homeWork_18
//
//  Created by Дмитрий Яковлев on 04.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation

class MyFifthClass<T:Numeric> {
    
    // Concurrent synchronization queue
    private let queue = DispatchQueue(label: "MyFifthClass.queue", attributes: .concurrent)
    
    var myArray :[T] = [0,1,2,3,4,5,6,7,8,9]
    
    let dispatchGroup = DispatchGroup()
    
    func start(){
        for i in 0...self.myArray.count - 1{
            queue.async{
                self.getResult(index: i, type: T.self)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            var res: T = 0
            self.myArray.forEach{ res += $0 }
            print( "MyFifthClass Result: \(res)")
        }
    }
    
    func getResult<T:Numeric>(index : Int, type: T.Type){
        let tmp = self.myArray[index]*self.myArray[index]
//        print(Thread.current)
        
        dispatchGroup.enter()
        queue.async(flags: .barrier) {
            self.myArray[index] = tmp
            self.dispatchGroup.leave()
        }
    }
    
    
}
