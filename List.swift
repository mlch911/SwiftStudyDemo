//
//  List.swift
//  SwiftStudyDemo
//
//  Created by mlch911 on 2019/4/9.
//  Copyright © 2019 mlch911. All rights reserved.
//

import Foundation

class ListNode {
    var value: Int
    var next: ListNode?
    
    init(value: Int) {
        self.value = value
    }
    init() {
        self.value = 0
    }
    init(value: Int, next: ListNode) {
        self.value = value
        self.next = next
    }
}

class List {
    var head: ListNode?
    var tail: ListNode?
    
    func appendToHead(value: Int) {
        let node = ListNode(value: value)
        if self.head == nil {
            self.head = node
        } else {
            node.next = self.head!
            self.head = node
        }
    }
    
    func appendToTail(value: Int) {
        let node = ListNode(value: value)
        if self.head == nil {
            self.head = node
        } else {
            self.tail?.next = node
        }
    }
}

//绝对路径返回相对路径，如"/home/user/"返回"/user"
func simplifyPath(path: String) -> String {
    var pathStack = [String]()
    let paths = path.components(separatedBy: "/")
    //处理"."
    for path in paths {
        guard path != "." else {
            continue
        }
        //处理".."
        if path == ".." {
            if pathStack.count > 0 {
                pathStack.removeLast()
            }
        } else if path != "" {
            pathStack.append(path)
        }
    }
    
    let res = pathStack.reduce("") {
        total , dir in "\(total)/\(dir)"
    }
    
    return res.isEmpty ? "/" : res
}
