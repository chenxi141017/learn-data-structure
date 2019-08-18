//
//  InsertionSort.swift
//  Stack
//
//  Created by chenxi on 2019/8/13.
//  Copyright © 2019 karma. All rights reserved.
//

import Foundation


class Sort {
    
    func insertionSort1(_ array: [Int]) -> [Int] {
        var a = array
        for x in 1 ..< a.count {
            var y = x
            while y > 0 && a[y] < a[y - 1] {
                a.swapAt(y-1, y)
                y -= 1
            }
        }
        return a
    }
    
    func insertionSort2(_ array: [Int]) -> [Int] {
        var a = array
        for x in 1..<a.count {
            var y = x
            let temp = a[y]
            while y > 0 && temp < a[y - 1] {
                a[y] = a[y - 1]
                y -= 1
            }
            a[y] = temp
        }
        return a
    }
    
    /// 插入排序
    ///
    /// - Parameters:
    ///   - array: 待排序数组
    ///   - isOrderdBefore: 排序方法
    /// - Returns: 已经排序数组
    /// - 复杂度: 时间复杂度 O(n^2), 空间复杂度 O(1)
    /// - 来源: https://en.wikipedia.org/wiki/Insertion_sort
    /// - 维基百科: https://aquarchitect.github.io/swift-algorithm-club/Insertion%20Sort/
    func insertionSort<T>(_ array: [T], _ isOrderdBefore: (T, T) -> Bool) -> [T] {
        var a = array
        for x in 1 ..< a.count {
            var y = x
            let temp = a[y]
            while y > 0 && isOrderdBefore(temp, a[y - 1]) {
                a[y] = a[y - 1]
                y -= 1
            }
            a[y] = temp
        }
        
        return a
    }
    
    /// - 来源: https://github.com/raywenderlich/swift-algorithm-club/blob/master/Merge%20Sort/README.markdown
    /// - https://www.cnblogs.com/nullzx/p/5968170.html
    
    // 自顶向下实现
    func mergeSortTopDown<T: Comparable>(_ array: [T]) -> [T] {
        // 1 退出递归条件
        guard array.count > 1 else { return array }
        
        let middleIndex = array.count / 2
        
        let leftArray = mergeSortTopDown(Array(array[0..<middleIndex]))
        let rightArray = mergeSortTopDown(Array(array[middleIndex..<array.count]))
        
        return merge(leftPile: leftArray, rightPile: rightArray)
    }
    
    func merge<T: Comparable>(leftPile: [T], rightPile: [T]) -> [T] {
        // both left and right are sorted.

        var orderdPile = [T]()
        orderdPile.reserveCapacity(leftPile.count + rightPile.count)
        
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < leftPile.count && rightIndex < rightPile.count {
            if leftPile[leftIndex] < rightPile[rightIndex] {
                orderdPile.append(leftPile[leftIndex])
                leftIndex += 1
            } else if leftPile[leftIndex] > rightPile[rightIndex] {
                orderdPile.append(rightPile[rightIndex])
                rightIndex += 1
            } else {
                orderdPile.append(leftPile[leftIndex])
                leftIndex += 1
                orderdPile.append(rightPile[rightIndex])
                rightIndex += 1
            }
        }
        
        
        while leftIndex < leftPile.count {
            orderdPile.append(leftPile[leftIndex])
            leftIndex += 1
        }

        while rightIndex < rightPile.count {
            orderdPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
        
        return orderdPile
    }
    
    // Bottom-up implementation
    func mergeSortBottomUp<T>(_ a: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        let n = a.count
        
        var z = [a, a]      // 1
        var d = 0
        
        var width = 1
        while width < n {   // 2
            
            var i = 0
            while i < n {     // 3
                
                var j = i
                var l = i
                var r = i + width
                
                let lmax = min(l + width, n)
                let rmax = min(r + width, n)
                
                while l < lmax && r < rmax {                // 4
                    if isOrderedBefore(z[d][l], z[d][r]) {
                        z[1 - d][j] = z[d][l]
                        l += 1
                    } else {
                        z[1 - d][j] = z[d][r]
                        r += 1
                    }
                    j += 1
                }
                while l < lmax {
                    z[1 - d][j] = z[d][l]
                    j += 1
                    l += 1
                }
                while r < rmax {
                    z[1 - d][j] = z[d][r]
                    j += 1
                    r += 1
                }
                
                i += width*2
            }
            
            width *= 2
            d = 1 - d      // 5
        }
        return z[d]
    }
    
    func countingSort(_ array: [Int]) -> [Int] {
        let maxElement = array.max() ?? 0
        
        var countArray = [Int](repeating: 0, count: (maxElement + 1))
        for element in array {
            countArray[element] += 1
        }
        
        for index in 1..<countArray.count {
            let sum = countArray[index] + countArray[index - 1]
            countArray[index] = sum
        }
        
        var sortedArray = [Int](repeating: 0, count: array.count)
        for element in array {
            countArray[element] -= 1
            let index = countArray[element]
            print(index)
            sortedArray[index] = element
        }
        
        return sortedArray
    }
    
    /// 冒泡排序
    ///
    /// - Parameters:
    ///   - array: 待排序数组
    ///   - isOrderdBefore: 排序条件
    /// - Returns: 已经排序数组
    func bubbleSort<T: Comparable>(array: inout [T], _ isOrderdBefore:(T, T) -> Bool) -> [T] {
        for i in 0 ..< array.count {
            for j in 1 ..< array.count - i {
                if isOrderdBefore(array[j], array[j - 1]) {
                    array.swapAt(j, j - 1)
                }
            }
        }
        return array
    }
    
    
    /// 选择排序
    ///
    /// - Parameters:
    ///   - array: 待排序数组
    ///   - isOrderedBefore: 排序条件
    /// - Returns: 已经排序数组
    func selectionSort<T: Comparable>(array: inout [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        guard array.count > 1 else { return array }
        
        for x in 0 ..< array.count {
            var position = x
            for y in x + 1 ..< a.count {
                if isOrderedBefore(array[y], array[x]) {
                    position = y
                }
            }
            if x != position {
                array.swapAt(x, position)
            }
        }
        
        return array
    }
    
    
    /// 希尔排序
    ///
    /// - Parameters:
    ///   - seq: 待排序数组
    ///   - isOrderedBeofre: 排序条件
    func shellsort<T : Comparable>(seq: inout [T], _ isOrderedBeofre:(T, T) -> Bool) {
        var gap = seq.count / 2
        while gap > 0 {
            for (var i, element) in seq.enumerated() {
                while i >= gap && isOrderedBeofre(element, seq[i - gap]) {
                    seq.swapAt(i, i - gap)
                    i -= gap
                }
            }
            if gap == 2 {
                gap = 1
            } else {
                gap = gap * 5 / 11
            }
        }
    }
    
    func quicksort<T: Comparable>(_ a: [T]) -> [T] {
        guard a.count > 1 else { return a }
        
        let pivot = a[a.count/2]
        let less = a.filter {$0 < pivot }
        let equal = a.filter {$0 == pivot }
        let greater = a.filter {$0 > pivot }
        return quicksort(less) + equal + quicksort(greater)
    }
    
    func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
        let pivot = a[high]
        var pivotIndex = low
        for j in low ..< high {
            if a[j] <= pivot {
                (a[pivotIndex], a[j]) = (a[j], a[pivotIndex])
                pivotIndex += 1
            }
        }
        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])
        return pivotIndex
    }
    
    func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
        if low < high {
            let p = partitionLomuto(&a, low: low, high: high)
            quicksortLomuto(&a, low: low, high: p - 1)
            quicksortLomuto(&a, low: p + 1, high: high)
        }
    }
    
    
    /// 快速排序
    ///
    /// - Parameters:
    ///   - array: 待排序数组
    ///   - isReverse: 是否颠倒排序，true 倒序， false 正xu
    /// - Returns: 排序之后数组
    func quickSort<T: Comparable>(_ array: [T], _ isReverse: Bool) -> [T] {
        guard array.count > 1 else { return array }
        
        var left = [T]()
        var right = [T]()
        var middle = [T]()
        let pivot = array.randomElement()!
        for item in array {
            if item == pivot {
                middle.append(item)
            } else if item < pivot {
                left.append(item)
            } else {
                right.append(item)
            }
        }
        if isReverse {
            return quickSort(right, isReverse) + middle + quickSort(left, isReverse)
        }
        return quickSort(left, isReverse) + middle + quickSort(right, isReverse)
    }
    
   
    
    /// 维护最大堆的性质
    ///
    /// - Parameters:
    ///   - array: 待排序数组
    ///   - i: 父节点
    ///   - size: 数组大小
    ///   - isOrderedBefore: 排序方式
    private func heapify<T: Comparable>(_ array: inout [T], _ i: Int, _ size: Int, _ isOrderedBefore: (T , T) -> Bool) {
        let left = 2 * i
        let right = left + 1
        var largest = i
        if left < size && isOrderedBefore(array[largest], array[left]) {
            largest = left
        }
        if right < size && isOrderedBefore(array[largest], array[right]) {
            largest = right
        }
        if largest != i {
            array.swapAt(i, largest)
            heapify(&array, largest, size, isOrderedBefore)
        }
    }
    
    /// 构建最大/小堆
    private func buildHeap<T: Comparable>(_ array: inout [T], _ isOrderedBefore: (T , T) -> Bool) {
        for i in stride(from: array.count/2, through: 0, by: -1) {
            heapify(&array, i, array.count, isOrderedBefore)
        }
    }
    
    /// 堆排序
    ///
    /// - Parameters:
    ///   - array: 待排序数组
    ///   - isOrderedBefore: 排序方式
    func heapSort<T: Comparable>(_ array: inout [T], _ isOrderedBefore: (T , T) -> Bool) {
        buildHeap(&array, isOrderedBefore)
        var size = array.count
        for index in stride(from: array.count - 1, through: 1, by: -1) {
            array.swapAt(index, 0)
            size -= 1
            heapify(&array, 0, size, isOrderedBefore)
        }
    }
}

