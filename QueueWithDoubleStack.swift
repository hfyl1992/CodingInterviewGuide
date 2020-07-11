import Foundation

struct Stack<Element> {
    private var wrapped = [Element]()

    var isEmpty: Bool {
        wrapped.isEmpty
    }

    mutating func push(_ element: Element) {
        wrapped.append(element)
    }

    mutating func pop() -> Element? {
        guard !wrapped.isEmpty else {
            return nil
        }
        return wrapped.removeLast()
    }

    func peek() -> Element? {
        return wrapped.last
    }

    func reversed() -> Self {
        var result = Self()
        var stack = self
        while !stack.isEmpty {
            if let element = stack.pop() {
                result.push(element)
            }
        }
        return result
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        return wrapped.description
    }
}

func + <Element>(lhs: Stack<Element>, rhs: Stack<Element>) -> Stack<Element> {
        var result = lhs
        var rhsPop = rhs
        var bbb = Stack<Element>()

        while !rhsPop.isEmpty {
            if let element = rhsPop.pop() {
                bbb.push(element)
            }
        }

        while !bbb.isEmpty {
         if let element = bbb.pop() {
                result.push(element)
            }
        }
        return result
}

struct QueueWithDoubleStack<Element> {
    private var stackPush = Stack<Element>()
    private var stackPop = Stack<Element>()

    mutating func add(_ element: Element) {
        stackPush.push(element)
        pushToTop()
    }

    @discardableResult
    mutating func poll() -> Element? {
        var element: Element?

        if !stackPop.isEmpty {
            element = stackPop.pop()
        }

        pushToTop()

        return element
    }

    func peek() -> Element? {
        return stackPop.peek()
    }

    private mutating func pushToTop() {
        guard stackPop.isEmpty else {
            return
        }

        while !stackPush.isEmpty {
            if let element = stackPush.pop() {
                stackPop.push(element)
            }
        }
    }
}

extension QueueWithDoubleStack: CustomStringConvertible {

    var description: String {
        return (stackPop.reversed()+stackPush).description
    }
}

var queue = QueueWithDoubleStack<Int>()

queue.add(1)
queue.add(2)
queue.add(3)

print(queue)

queue.poll()
print(queue)

queue.poll()
print(queue)

queue.add(4)
queue.add(5)

print(queue)

queue.poll()
print(queue)
