

import Foundation

struct KeysForDropBox_json {
    static let categories_array = "mpl5o_list"
    static let categories_img = "mpl5oi1"
    static let categories_title = "mpl5ot3"
    
    static let mod_array = "xuxot6p"//"rmigva"
    static let mod_file = "v_s"//"h34s"
    static let mod_desc = "0hne"//"kchzzq"
    static let mod_img = "liygu-3yr"//"0y-y"
    static let mod_title = "7zroa6ty5"//"rkgz5"
    static let mod_new = "new"
    
    static let mod_editor_content = "tqd-lhf_list"//p3lmxd_list"
    static let mod_editor_img = "jrk-t3"//"p3lmxdf2"
    
    static let robots_category = "Robots"
    static let bakcgrounds_category = "Backgrounds"
    static let boatsAndShips_category = "Boats and ships"
    static let weapons_category = "Weapons"
    
    static let noData = "noData"
    static let Mods = "Mods"
    static let Categories = "Categories"
    static let Items = "Items"
    static let EditorItems = "EditorItems"
    static let RefreshTokenSaveVarieble = "refresh_token"
    static let pathMods = "/mods"
}

struct ModelForDropBoxItems : Equatable, Codable {
    var title = String()
    var desc = String()
    var category = String()
    var file = String()
    var img = String()
    var type = String()
    var isNew = String()
}


struct ModelForDropBoxItemsCategory : Equatable, Codable {
    var category = String()
    var categoryImage = String()
    var type = String()
}

struct ModelDropBoxEditorSmallItems : Equatable, Codable {
    var category = String()
    var image = String()
    var type = String()
    var tag = String()
}

enum ModelForDropBoxItemsType {
    case mods, category, editorItems
    
    var getKey: String {
        switch self {
        case .mods:
            return KeysForDropBox_json.Mods
        case .category:
            return KeysForDropBox_json.Categories
        case .editorItems:
            return KeysForDropBox_json.EditorItems
        }
    }
    
    var path : String {
        switch self {
        case .mods:
            return KeysForDropBox_json.pathMods
        case .category:
            return ""
        case .editorItems:
            return ""
        }
    }
}
