//
//  TreeNode.swift
//  SwiftStudyDemo
//
//  Created by mlch911 on 2019/4/6.
//  Copyright © 2019 mlch911. All rights reserved.
//

import Foundation

class TreeNode {
    var value: Int
    var leftChild: TreeNode?
    var rightChild: TreeNode?
    private var leftSpace = 0
    private var rightSpace = 0
    private var preSpace = 0
    private var result: [Int] = []
    
    init() {
        self.value = 0
    }
    init(value: Int) {
        self.value = value
    }
    init(value: Int, lChild: TreeNode?, rChild: TreeNode?) {
        self.value = value
        if lChild != nil {
            self.leftChild = lChild
        }
        if rChild != nil {
            self.rightChild = rChild
        }
    }
    
    func clearResult() {
        result = []
    }
    
    func createTree(data: [Int]) {
        self.value = data[0]
        for i in 0 ..< data.count {
            createNode(node: self, data: data[i])
        }
    }
    
    func createNode(node: TreeNode, data: Int) {
        if data > node.value {
            if node.rightChild != nil {
                createNode(node: node.rightChild!, data: data)
            } else {
                node.rightChild = TreeNode(value: data)
            }
        }
        if data < node.value {
            if node.leftChild != nil {
                createNode(node: node.leftChild!, data: data)
            } else {
                node.leftChild = TreeNode(value: data)
            }
        }
    }
    
    func maxDepth(root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return max(maxDepth(root: root.leftChild), maxDepth(root: root.rightChild)) + 1
    }
    
    //是否为二叉查找树
    func isValid(root: TreeNode?) -> Bool {
        return _helper(node: root, nil, nil)
    }
    
    func _helper(node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
        guard let node = node else {
            return true
        }
        //所有右节点大于根节点
        if let min = min, node.value <= min {
            return false
        }
        ////所有左节点小于根节点
        if let max = max, node.value >= max {
            return false
        }
        
        return _helper(node: node.leftChild, min, node.value) && _helper(node: node.rightChild, node.value, max)
    }
    
    
    //前序遍历
    func preorderTraverse(rootNode: TreeNode) -> [Int] {
        result.append(rootNode.value)
        if rootNode.leftChild != nil {
            let _ = preorderTraverse(rootNode: rootNode.leftChild!)
        }
        if rootNode.rightChild != nil {
            let _ = preorderTraverse(rootNode: rootNode.rightChild!)
        }
        return result
    }
    
    //中序遍历
    func inorderTraverse(rootNode: TreeNode) -> [Int] {
        if rootNode.leftChild != nil {
            let _ = inorderTraverse(rootNode: rootNode.leftChild!)
        }
        result.append(rootNode.value)
        if rootNode.rightChild != nil {
            let _ = inorderTraverse(rootNode: rootNode.rightChild!)
        }
        return result
    }
    
    //后续遍历
    func postorderTraverse(rootNode: TreeNode) -> [Int] {
        if rootNode.leftChild != nil {
            let _ = postorderTraverse(rootNode: rootNode.leftChild!)
        }
        if rootNode.rightChild != nil {
            let _ = postorderTraverse(rootNode: rootNode.rightChild!)
        }
        result.append(rootNode.value)
        return result
    }
    
    //层次遍历1
    func levelOrderTraverse1(rootNode: TreeNode) -> [Int] {
        var queue: [TreeNode] = []
        queue.append(rootNode)
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if let left = node.leftChild {
                queue.append(left)
            }
            if let right = node.rightChild {
                queue.append(right)
            }
            result.append(node.value)
        }
        return result
    }
    
    //层次遍历2
    func levelOrderTraverse2(rootNode: TreeNode) -> [[Int]] {
        var res: [[Int]] = []
        var queue: [TreeNode] = []
        queue.append(rootNode)
        while !queue.isEmpty {
            let size = queue.count
            var level: [Int] = []
            for _ in 0..<size {
                let node = queue.removeFirst()
                level.append(node.value)
                if let left = node.leftChild {
                    queue.append(left)
                }
                if let right = node.rightChild {
                    queue.append(right)
                }
            }
            res.append(level)
        }
        return res
    }
}

//树形输出
extension TreeNode {
    func display() {
        let _ = self.calc_space(node: self)
        let tree = self.levelOrderTraverse2(rootNode: self)
        var queue: [TreeNode] = []
        queue.append(self)
        for level in tree {
            var mark: [Bool] = []
            var location: [Int] = []
            var count = level.count
            var right = 0
            while count > 0 {
                let node = queue.removeFirst()
                let last = location.last ?? 0
                let loca = last + right + node.leftSpace + node.preSpace - 1
                printNode(node: node)
                if node.leftChild != nil {
                    mark.append(false)
                    location.append(loca)
                    queue.append(node.leftChild!)
                }
                if node.rightChild != nil {
                    mark.append(true)
                    location.append(loca + calc_characters(value: node.value) + 1)
                    queue.append(node.rightChild!)
                }
                if node.rightChild != nil {
                    right = node.rightSpace
                } else if node.leftChild != nil {
                    right += 3
                } else {
                    right = right + node.preSpace + node.leftSpace + calc_characters(value: node.value) + node.rightSpace
                }
                count -= 1
            }
            print("")
            var i = 0
            var result = ""
            while !mark.isEmpty {
                if i == location.first! {
                    if mark.first! {
                        result += "\\"
                        i += 1
                        mark.removeFirst()
                        location.removeFirst()
                    } else {
                        result += "/"
                        i += 1
                        mark.removeFirst()
                        location.removeFirst()
                    }
                } else {
                    result += " "
                    i += 1
                }
            }
            print(result)
        }
    }
    
    func printNode(node: TreeNode) {
        var result = ""
        for _ in 0..<node.leftSpace + node.preSpace {
            result += " "
        }
        result += "\(node.value)"
        for _ in 0..<node.rightSpace {
            result += " "
        }
        print(result, separator: "", terminator: "")
    }
    
    func calc_characters(value: Int) -> Int {
        if value == 0 {
            return 1
        }
        var data = value
        var characters = 0
        while data > 0 {
            characters += 1
            data = data / 10
        }
        return characters
    }
    
    func calc_space(node: TreeNode) -> TreeNode {
        if node.leftChild == nil && node.rightChild == nil {    //无子节点
            node.leftSpace = 0
            node.rightSpace = 0
        } else if node.leftChild != nil && node.rightChild == nil {     //无右子节点
            node.rightSpace = 0
            node.leftChild?.preSpace = calc_characters(value: node.value)
            node.leftSpace = calc_space(node: node.leftChild!).leftSpace + calc_characters(value: node.leftChild!.value) + calc_space(node: node.leftChild!).rightSpace
        } else if node.leftChild == nil && node.rightChild != nil {     //无左子节点
            node.leftSpace = 0
            node.rightChild?.preSpace = calc_characters(value: node.value)
            node.rightSpace = calc_space(node: node.rightChild!).leftSpace + calc_characters(value: node.rightChild!.value) + calc_space(node: node.rightChild!).rightSpace
        } else {    //左右均有
            node.leftChild!.preSpace = node.preSpace
            node.rightChild!.preSpace = calc_characters(value: node.value)
            node.leftSpace = calc_space(node: node.leftChild!).leftSpace + calc_characters(value: node.leftChild!.value) + calc_space(node: node.leftChild!).rightSpace
            node.rightSpace = calc_space(node: node.rightChild!).leftSpace + calc_characters(value: node.rightChild!.value) + calc_space(node: node.rightChild!).rightSpace
        }
        return node
    }
}
