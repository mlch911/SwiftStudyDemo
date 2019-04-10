//
//  main.swift
//  SwiftStudyDemo
//
//  Created by mlch911 on 2019/4/6.
//  Copyright © 2019 mlch911. All rights reserved.
//

import Foundation

var root = TreeNode()


//树
//let nums = [61, 87, 59, 47, 35, 73, 51, 98, 37, 93]
let nums = [61, 87, 59, 47, 35, 73, 51, 98, 37, 93, 34, 48, 58]
root.createTree(data: nums)
//print("前序遍历：")
//root.clearResult()
//print(root.preOrderTraverse(rootNode: root), separator: " ", terminator: "\n")
//print("\n中序遍历：")
//root.clearResult()
//print(root.inOrderTraverse(rootNode: root), separator: " ", terminator: "\n")
//print("\n后序遍历：")
//root.clearResult()
//print(root.postOrderTraverse(rootNode: root), separator: " ", terminator: "\n")
//print("\n层次遍历1：")
//root.clearResult()
//print(root.levelOrderTraverse1(rootNode: root), separator: " ", terminator: "\n")
//print("\n层次遍历2：")
//print(root.levelOrderTraverse2(rootNode: root), separator: " ", terminator: "\n")
//print("")
//root.display()


print(simplifyPath(path: "/a/b/../c"))
