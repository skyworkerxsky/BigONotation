import UIKit


// нахождение суммы двух чисел которые дают target
func twoSum(array: [Int], target: Int) -> [Int] {
    var dictionary: [Int: Int] = [:]
    var resultArray: [Int] = []
    
    for (i, j) in array.enumerated() {
        if let index = dictionary[target - j] {
            resultArray.append(index)
            resultArray.append(i)
            return resultArray
        }
        dictionary[j] = i
    }
    return resultArray
}

twoSum(array: [4,6,7,3,5,24,3,12], target: 13)


// удаление дубликатов из отсортированного массива
var arr1 = [0,0,1,1,3,4,4,4,5,5,8,8,9,0,4,5].sorted()

func removeDuplicates(arr: inout [Int]) -> Int {
    var last: Int?
    var index: Int = 0
    
    while index < arr.count {
        if arr[index] == last {
            arr.remove(at: index)
        } else {
            last = arr[index]
            index += 1
        }
    }
    return arr.count
}

removeDuplicates(arr: &arr1)


/*
 Проблема: Найти кратчайший несортированный, непрерывный массив в подмассиве.
 Описание: На вход подается массив, в этом массиве нужно найти такой подмассив, который, если вы сортируете в порядке ворастания, отсортирует весь массив в порядке возрастания.
 */


func findUnsortedSubarray(array: [Int]) -> Int {
    
    let n = array.count
    
    var minNum = array[n - 1]
    var start = 1
    
    var maxNum = array[0]
    var end = 0
    
    for (index, currentItem) in array.enumerated() {
        maxNum = max(maxNum, currentItem)
        if currentItem < maxNum {
            end = index
            //            print(end)
        }
    }
    
    for (index, currentItem) in array.enumerated() {
        minNum = min(minNum, array[n - 1 - index])
        if array[n - 1 - index] > minNum {
            start = n - 1 - index
        }
    }
    
    return end - start + 1
}

var arraySub = [1,4,2,3,2,6] // длинна подмассива 4

findUnsortedSubarray(array: arraySub)
findUnsortedSubarray(array: [3,6,8,2,4,1,5,7, 23])
findUnsortedSubarray(array: [1,1])


// перевернуть строку

func reverseString(str: inout [Character]) {
    var last = str.count - 1
    var first: Int = 0
    while first < last {
        let temp = str[first]
        str[first] = str[last]
        str[last] = temp
        first += 1
        last -= 1
    }
}

var charArray: [Character] = ["T", "n", "q", "2", "1"]
reverseString(str: &charArray)

/*
 Строка с одним отличием
 Проблема: Написать функцию которая вернет true если в двух строках между нии будет более одного отличия
*/

// с одинаковой длиной
// hello
// helli
func isOneAwaySameLenght(firstStr: String, secondStr: String) -> Bool {
    
    var countDifferent = 0  // кол-во изменений
    
    for i in 0...firstStr.count - 1 {
        
        let indexFirst = firstStr.index(firstStr.startIndex, offsetBy: i)      // вытаскиваем по индексу символ
        let indexSecond = secondStr.index(secondStr.startIndex, offsetBy: i)
        
        // перва
        if firstStr[indexFirst] != secondStr[indexSecond] {
            countDifferent += 1
            if countDifferent > 1 {
                return false
            }
        }
        
    }
    
    return true
}

// различное длина элементов (вторая меньше чем первая)
// hello
// helo
func isOneAwayDiffLenght(firstStr: String, secondStr: String) -> Bool {
    
    var countDifferent = 0
    var i = 0
    
    while i < secondStr.count {
        
        let indexFirst = firstStr.index(firstStr.startIndex, offsetBy: i + countDifferent)
        let indexSecond = secondStr.index(secondStr.startIndex, offsetBy: i)
        
        if firstStr[indexFirst] == secondStr[indexSecond] {
            i += 1
        } else {
            countDifferent += 1
            if countDifferent > 1 {
                return false
            }
        }
    }
    return true
}

// объеденили все в одну функцию
func isOneAway(firstStr: String, secondStr: String) -> Bool {
    if firstStr.count - secondStr.count >= 2 || secondStr.count - firstStr.count >= 2 {
        return false
    } else if firstStr.count == secondStr.count {
        return isOneAwaySameLenght(firstStr: firstStr, secondStr: secondStr)
    } else if firstStr.count > secondStr.count {
        return isOneAwayDiffLenght(firstStr: firstStr, secondStr: secondStr)
    } else {
        return isOneAwayDiffLenght(firstStr: secondStr, secondStr: firstStr)
    }
}

isOneAway(firstStr: "hello", secondStr: "heli")
isOneAway(firstStr: "helo", secondStr: "heli")
isOneAway(firstStr: "hello", secondStr: "hello")
