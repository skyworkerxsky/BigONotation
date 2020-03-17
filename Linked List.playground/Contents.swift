import UIKit

/*
 Linked List (связанный список)
 Каждый объект в списке содержит значение и ссылку на следующий объект
 
 3 -> 6 -> 8 -> 21 -> nil
 
 */

// создаем linked list
class ListNode<T> {
    var value: T
    var prev: ListNode?
    var next: ListNode?
    
    init(value: T) {
        self.value = value
    }
}

struct LinkedList<T>: CustomStringConvertible {
    
    var description: String { // позволяет вывести весь List
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node?.next
            if node != nil {
                text += ", "
            }
        }
        return text + "]"
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: ListNode<T>? {
        return head
    }
    
    var last: ListNode<T>? {
        return tail
    }
    
    private var head: ListNode<T>?
    private var tail: ListNode<T>?
    
    mutating func append(value: T) {
        let newNode = ListNode(value: value)
        if tail != nil {
            newNode.prev = tail
            tail?.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    mutating func remove(node: ListNode<T>) -> T {
        // фиксируем след и пред элементы от удаляемого
        let prev = node.prev
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.prev = prev
        
        if next == nil {
            tail = prev
        }
        
        node.prev = nil
        node.next = nil
        
        return node.value
    }
    
}

// функция для вывода всех элементов в связаном списке (но лучше использовать св-во description)
func printList<T>(head: ListNode<T>?) {

    var currentNode = head

    while currentNode != nil {
        print(currentNode?.value ?? "-1")
        currentNode = currentNode?.next
    }
}

var list = LinkedList<Int>()
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)
list.append(value: 5)
list.remove(node: list.first!)
list.description

var list2 = LinkedList<String>()
list2.append(value: "abc")
list2.append(value: "zzz")
list2.isEmpty
list2.description
list2.first?.value


/*
 Перевернуть Linked List
 
 3 -> 6 -> 12 -> 15 -> nil
 
 15 -> 12 -> 6 -> 3 -> nil
 
 Time: O(N)
 */

//func reverseList(head: ListNode?) -> ListNode? {
//
//    var currentNode = head
//    var prev: ListNode?
//    var next: ListNode?
//
//    while currentNode != nil {
//        next = currentNode?.next
//        currentNode?.next = prev
//        prev = currentNode
//        currentNode = next
//    }
//    return prev
//}

/*
 Объеденить по значениям два отсортированных списка
 
 1 -> 4 -> 6 -> nil
 2 -> 3 -> 8 -> nil
 
 1 -> 2 -> 3 -> 4 -> 6 -> 8 -> nil
 
 Time: O(m + n)
 */

//func mergeTwoList(list1: ListNode?, list2: ListNode?) -> ListNode? {
//
//    guard list1 != nil else { return list2 }
//    guard list2 != nil else { return list1 }
//
//    let dummyHead: ListNode = ListNode(value: 0, next: nil) // первое число
//    var l1 = list1
//    var l2 = list2
//    var endOfSortedList: ListNode? = dummyHead
//
//    while l1 != nil && l2 != nil {
//        if l1!.value <= l2!.value {
//            endOfSortedList!.next = l1
//            l1 = l1!.next
//        } else {
//            endOfSortedList!.next = l2
//            l2 = l2!.next
//        }
//        endOfSortedList = endOfSortedList?.next
//    }
//
//    endOfSortedList?.next = l1 == nil ? l2 : l1
//    return dummyHead.next
//
//}
