//
//  Fourth.swift
//  homeWork_18
//
//  Created by Дмитрий Яковлев on 04.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation



class MyFourthClass<T:Numeric>{
    
    var myArray :[T] = [0,1,2,3,4,5,6,7,8,9]
    var lock = NSLock()
    let dispatchGroup = DispatchGroup()
    
    
    init(){
        
    }
    
    func start(){
        mySuperOperation()
    }
    
    func mySuperOperation() {

        var operations: (() -> Void)!
        operations = {
            let queue1 = OperationQueue()
            
            let resultBlockOperation = BlockOperation {
                var res: T = 0
                self.myArray.forEach{
                    res += $0 }
                print( "MyFourthClass Result: \(res)")
            }
            
            for index in 0...self.myArray.count-1{
                let blockOperation = BlockOperation {
                    self.getResult(index: index, type: T.self)
                }
                queue1.addOperation(blockOperation)
                resultBlockOperation.addDependency(blockOperation)
            }
            
            OperationQueue().addOperation(resultBlockOperation)
        }
        operations()
    }
    
    
    
    
    
    
    func getResult<T:Numeric>(index : Int, type: T.Type){
        let tmp = self.myArray[index]*self.myArray[index]
        self.lock.lock()
        self.myArray[index] = tmp
        self.lock.unlock()
    }
    
    
}
