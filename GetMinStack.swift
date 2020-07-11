import Foundation

struct GetMinStack<Element: Comparable> {
    private var wrapped = [Element]()
    private var minWrapped = [Element]()

    mutating func push(_ element: Element) {
        if wrapped.isEmpty {
            minWrapped.append(element)
        } else {
            if element <= minWrapped.last! {
                minWrapped.append(element)
            }
        }
        wrapped.append(element)
    }

    @discardableResult
    mutating func pop() -> Element? {
        guard !wrapped.isEmpty else {
            return nil
        }
        let removed = wrapped.removeLast()
        if removed == minWrapped.last {
            minWrapped.removeLast()
        }
        return nil
    }

    func getMin() -> Element? {
        return minWrapped.last
    }
}

extension GetMinStack: CustomStringConvertible {
    var description: String {
        return wrapped.description
    }
}

var stack = GetMinStack<Int>()
for _ in 0...20 {
    stack.push(Int.random(in: 0...300))
}

for _ in 0...20 {
    stack.pop()
    print("stack: \(stack)")
    print("stack min: \(stack.getMin())\n")
}
