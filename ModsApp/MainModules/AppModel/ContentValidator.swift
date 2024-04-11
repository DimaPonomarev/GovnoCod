
import Foundation

final class ActionCustomValidator: NSObject {
    
    static let shared = ActionCustomValidator()
    private var actionCount: Int = 0
    private var rewardedCount: Int = 0
    
    struct DefaultStruct {
        static let noname = "string"
    }
    
    func lets_checkActionCountable(completion: @escaping () -> ()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if actionCount == 7 {
            actionCount = 0
            print("show ads. action count is ", actionCount)
            completion()
        } else {
            actionCount += 1
            print("action count is ", actionCount)
        }
    }

}

final class ContentMagicUnLocker {
    
    static let shared = ContentMagicUnLocker()
    
    var isLocked = false
    var isPushedFromApp = false
    var isLostConnection = false
    
    struct DefaultStruct {
        static let noname = "string"
    }
 
}
