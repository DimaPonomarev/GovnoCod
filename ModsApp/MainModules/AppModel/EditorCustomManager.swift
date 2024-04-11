
import Foundation

struct ForEditorItem: Equatable {
    var id: String = ""
    var name: String = ""
    //    var imagePath: String = ""
    var imageData: Data = Data()
    var iconData: Data = Data()
    var type: String = ""
    var category: String = ""
    
    var xValue: String = ""
    var yValue: String = ""
    var heightValue: String = ""
    var widthValue: String = ""
    
    var pixelValue: String = ""
    
    var canBeTaken: Bool = false
    var canGlow: Bool = false
    var canBurn: Bool = false
    var canFloat: Bool = false
}


final class EditorCustomManager {
 
    static let shared = EditorCustomManager()
    
    var oldItem: ForEditorItem!
    var newItem: ForEditorItem!
    
    func lets_compareOldNewItems(completion: @escaping (Bool) -> ()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if oldItem == newItem {
            print("all ok")
            completion(false)
        } else {
            print("need to change")
            completion(true)
        }
    }
    
}
