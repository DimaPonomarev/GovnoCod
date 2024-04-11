

import Foundation
import RealmSwift

final class ModRealmModelElement: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var modTitle: String = ""
    @objc dynamic var modDescription: String = ""
    @objc dynamic var modFilePath: String = ""
    @objc dynamic var modImagePath: String = ""
    @objc dynamic var modImageData: Data = Data()
    @objc dynamic var isNew: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var isDownloaded: Bool = false
    // category
    @objc dynamic var categoryName: String = ""
    @objc dynamic var categoryImagePath: String = ""
    @objc dynamic var categoryImageData: String = ""
    
    @objc dynamic var defaultName: String = ""
}

final class CategoryRealmModelElement: Object {
    @objc dynamic var categoryName: String = ""
    @objc dynamic var categoryImagePath: String = ""
    @objc dynamic var categoryImageData: Data = Data()
    
    @objc dynamic var defaultName: String = ""
}


final class EditorItemRealmModelElement: Object {
    // settings
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = "name"
    @objc dynamic var imagePath: String = ""
    @objc dynamic var imageData: Data = Data()
    @objc dynamic var type: String = "type"
    @objc dynamic var category: String = "category"
    @objc dynamic var tag: String = "LIVING TEMPLATES"
    // coliders
    @objc dynamic var xValue: String = "0.0"
    @objc dynamic var yValue: String = "0.0"
    @objc dynamic var heightValue: String = "0.0"
    @objc dynamic var widthValue: String = "0.0"
    // poxel
    @objc dynamic var pixelValue: String = "0"
    // properties
    @objc dynamic var canBeTaken: Bool = false
    @objc dynamic var canGlow: Bool = false
    @objc dynamic var canBurn: Bool = false
    @objc dynamic var canFloat: Bool = false
    
    @objc dynamic var defaultName: String = ""
}

final class EditorItemLocalRealmModelElement: Object {
    // settings
    @objc dynamic var id: String = ""
    @objc dynamic var idInt: Int = 0
    @objc dynamic var name: String = "name"
    @objc dynamic var imagePath: String = ""
    @objc dynamic var imageData: Data = Data()
    @objc dynamic var type: String = "type"
    @objc dynamic var category: String = "category"
    // coliders
    @objc dynamic var xValue: String = "0.0"
    @objc dynamic var yValue: String = "0.0"
    @objc dynamic var heightValue: String = "0.0"
    @objc dynamic var widthValue: String = "0.0"
    // poxel
    @objc dynamic var pixelValue: String = "0"
    // properties
    @objc dynamic var canBeTaken: Bool = false
    @objc dynamic var canGlow: Bool = false
    @objc dynamic var canBurn: Bool = false
    @objc dynamic var canFloat: Bool = false
    
    @objc dynamic var iconData: Data = Data()
    
    @objc dynamic var defaultName: String = ""
}
