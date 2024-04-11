
import Foundation
import RealmSwift


final class CoreDataBase: NSObject {
    
    public static let shared = CoreDataBase()
    
    private override init() {
        super.init()
    }
    
    static let config = Realm.Configuration(schemaVersion: 3, migrationBlock: { migration, oldSchemaVersion in
        switch oldSchemaVersion {
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    })
    
    let realm = try! Realm(configuration: CoreDataBase.config)
    lazy var mods: Results<ModRealmModelElement> = { realm.objects(ModRealmModelElement.self) }()
    lazy var categories: Results<CategoryRealmModelElement> = { realm.objects(CategoryRealmModelElement.self) }()
    lazy var editorItems: Results<EditorItemRealmModelElement> = { realm.objects(EditorItemRealmModelElement.self) }()
    lazy var editorItemsLocal: Results<EditorItemLocalRealmModelElement> = { realm.objects(EditorItemLocalRealmModelElement.self) }()
    

    
    func saveEditorBlueItem(mod: EditorItemRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        try! realm.write{
            realm.add(mod)
        }
    }
    
    func editorUpdateBlueImageData(obj: EditorItemRealmModelElement, data: Data) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["imageData" : data])
    }
    
    func saveBlueEditorItemLocal(mod: EditorItemLocalRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        try! realm.write{
            realm.add(mod)
        }
    }
    
    func lets_editorUpdatename(obj: EditorItemLocalRealmModelElement, name: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["name" : name])
    }
    
    func editorBlueUpdateImageData(obj: EditorItemLocalRealmModelElement, data: Data) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["imageData" : data])
    }
    
    func editorBlueUpdateType(obj: EditorItemLocalRealmModelElement, type: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["type" : type])
    }
    
    func editorBlueUpdateCategory(obj: EditorItemLocalRealmModelElement, category: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["category" : category])
    }
    
    func editorBlueUpdate_xValue(obj: EditorItemLocalRealmModelElement, xValue: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["xValue" : xValue])
    }
    
    func editorBlueUpdate_yValue(obj: EditorItemLocalRealmModelElement, yValue: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["yValue" : yValue])
    }
    
    func editorBlueUpdate_heightValue(obj: EditorItemLocalRealmModelElement, heightValue: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["heightValue" : heightValue])
    }
    
    func editorBlueUpdate_widthValue(obj: EditorItemLocalRealmModelElement, widthValue: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["widthValue" : widthValue])
    }
    
    func editorBlueUpdate_canBeTaken(obj: EditorItemLocalRealmModelElement, canBeTaken: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["canBeTaken" : canBeTaken])
    }
    
    func editorBlueUpdate_canGlow(obj: EditorItemLocalRealmModelElement, canGlow: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["canGlow" : canGlow])
    }
    
    func editorBlueUpdate_canBurn(obj: EditorItemLocalRealmModelElement, canBurn: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["canBurn" : canBurn])
    }
    
    func editorBlueUpdate_canFloat(obj: EditorItemLocalRealmModelElement, canFloat: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["canFloat" : canFloat])
    }
    
    func editorBlueUpdate_pixelValue(obj: EditorItemLocalRealmModelElement, pixelValue: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["pixelValue" : pixelValue])
    }
    
    func saveBlueModsToRealmssss(mod: ModRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        try! realm.write{
            realm.add(mod)
        }
    }
    
    func saveBlueCategoryToRealm(cat: CategoryRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        try! realm.write{
            realm.add(cat)
        }
    }
    
    func clearBlueRealm() {
        struct DefaultStruct {
            static let noname = "string"
        }
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    /// mod Change Image Data
    func modChangeBlueImageData(mod: ModRealmModelElement, modImageData: Data) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(mod, with: ["modImageData" : modImageData])
    }
    
    /// Category Change Image Data
    func categoryBlueChangeImageData(cat: CategoryRealmModelElement, categoryImageData: Data) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(cat, with: ["categoryImageData" : categoryImageData])
    }
    
    /// HELPER update Object
    private func updateBlueObjectsssss(_ object: Object, with dictionary: [String: Any?]) {
        struct DefaultStruct {
            static let noname = "string"
        }
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print("⚠️Failed \(error.localizedDescription)")
        }
    }
    
    
    func editorUpdateLocalMod(obj: EditorItemLocalRealmModelElement, localMod: ForEditorItem) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.updateBlueObjectsssss(obj, with: ["id" : localMod.id])
        self.updateBlueObjectsssss(obj, with: ["type" : localMod.type])
        self.updateBlueObjectsssss(obj, with: ["name" : localMod.name])
        self.updateBlueObjectsssss(obj, with: ["imageData" : localMod.imageData])
        self.updateBlueObjectsssss(obj, with: ["iconData" : localMod.iconData])
        self.updateBlueObjectsssss(obj, with: ["category" : localMod.category])
        self.updateBlueObjectsssss(obj, with: ["xValue" : localMod.xValue])
        self.updateBlueObjectsssss(obj, with: ["yValue" : localMod.yValue])
        self.updateBlueObjectsssss(obj, with: ["heightValue" : localMod.heightValue])
        self.updateBlueObjectsssss(obj, with: ["widthValue" : localMod.widthValue])
        self.updateBlueObjectsssss(obj, with: ["pixelValue" : localMod.pixelValue])
        self.updateBlueObjectsssss(obj, with: ["canBeTaken" : localMod.canBeTaken])
        self.updateBlueObjectsssss(obj, with: ["canGlow" : localMod.canGlow])
        self.updateBlueObjectsssss(obj, with: ["canBurn" : localMod.canBurn])
        self.updateBlueObjectsssss(obj, with: ["canFloat" : localMod.canFloat])
    }
}
