import Foundation

final class CallStation {
    var userList: [User] = []
    var callList: [Call] = []
}

extension CallStation: Station {
    func users() -> [User] {
        return userList
    }
    
    func add(user: User) {
        if !userList.contains(user){
        userList.append(user)
        }
    }
    
    func remove(user: User) {
        if let index = userList.firstIndex(of: user) {
            userList.remove(at: index)        }

    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case let .start(from: user1, to: user2):
            print ("Entered to the switch")
            
            if !userList.contains(user1) && !userList.contains(user2) {
                print("No User1 & No User2")
                return nil
                
            } else if !userList.contains(user2) {
                print("No user2")
                let call = Call(id: UUID.init(), incomingUser: user1, outgoingUser: user2, status: .ended(reason: .error))
                callList.append(call)
                return call.id
                }
                    
            if self.currentCall(user: user2) != nil {
                print("User2 busy")
                let call = Call(id: UUID.init(), incomingUser: user1, outgoingUser: user2, status: .ended(reason: .userBusy))
                callList.append(call)
                } else {
                    print("CALLING")
                    let call = Call(id: UUID.init(), incomingUser: user1, outgoingUser: user2, status: .calling)
                    callList.append(call)
                    }
                    
                    if let index = callList.firstIndex(where: { $0.incomingUser == user1 && $0.outgoingUser == user2 }) {
                        return callList[index].id
                    }
                    
                    return nil
                    
        case let .answer(from: user):
            if !userList.contains(user) {
                if let index = callList.firstIndex(where: { $0.outgoingUser == user }) {
                    callList[index].status = .ended(reason: .error)
                    }
                return nil
                }
                    
            let callId = calls(user: user).first?.id
                    
            if let index = callList.firstIndex(where: { $0.id == callId }) {
                if callList[index].status == .calling {
                    callList[index].status = .talk
                    }
                }
                    
                    return callId
                    
        case let .end(from: user):
            let callId = calls(user: user).first?.id
                    
            if callList.contains(where: { $0.id == callId }) {
                if let index = callList.firstIndex(where: { $0.id == callId }) {
                    if callList[index].status == .calling {
                        callList[index].status = .ended(reason: .cancel)
                    }
                    
                    if callList[index].status == .talk {
                        callList[index].status = .ended(reason: .end)
                            }
                        }
                    }
                    
                    return callId
                }
    }
    
    func calls() -> [Call] {
       return callList
    }
    
    func calls(user: User) -> [Call] {
        var callOfThisUser: [Call] = []
        callList.forEach { call in
            if call.incomingUser == user || call.outgoingUser == user {
                callOfThisUser.append(call)
            }
        }
        return callOfThisUser
    }
    
    func call(id: CallID) -> Call? {
        var tempId: Call = callList.first!
        callList.forEach { value in
            if value.id == id {
                tempId = value
            }
        }
        return tempId
    }
    
    func currentCall(user: User) -> Call? {
        
        return callList.filter({($0.incomingUser == user || $0.outgoingUser == user) && ($0.status == .calling || $0.status == .talk) }).first
    }
}
