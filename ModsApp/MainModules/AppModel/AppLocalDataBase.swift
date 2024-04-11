

import Foundation

final class LocalDataOnThisApp {
    
    static let shared = LocalDataOnThisApp()
    
    var categories: [CategoryRealmModelElement] = []
    var mods: [ModRealmModelElement] = []
    var editorItems: [EditorItemRealmModelElement] = []
    var editorItemsSaved: [EditorItemLocalRealmModelElement] = []
    
    func lets_getEvilCategory(by: String) -> [ModRealmModelElement] {
        struct DefaultStruct {
            static let noname = "string"
        }
        var sortedMods: [ModRealmModelElement] = []
        sortedMods = mods.filter({$0.categoryName.contains(by)})
        return sortedMods
    }
    
    func lets_getLivingTemplates() -> [EditorItemRealmModelElement] {
        struct DefaultStruct {
            static let noname = "string"
        }
        var sortedTemplates: [EditorItemRealmModelElement] = []
        sortedTemplates = editorItems.filter( {$0.tag == "LIVING TEMPLATES"} )
        return sortedTemplates
    }
    
    func lets_getMiscTemplates() -> [EditorItemRealmModelElement] {
        struct DefaultStruct {
            static let noname = "string"
        }
        var sortedTemplates: [EditorItemRealmModelElement] = []
        sortedTemplates = editorItems.filter( {$0.tag == "MISC TEMPLATES"} )
        return sortedTemplates
    }
    
}
