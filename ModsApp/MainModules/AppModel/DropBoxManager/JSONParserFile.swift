

import Foundation
import SwiftyDropbox

protocol DropBoxDelegateBlueProtocol : AnyObject {
    func currentProgressOperation(progress : Progress)
    func isReadyAllContent()
}

final class DropBoxBeautifulManager : NSObject {
    
    static let shared = DropBoxBeautifulManager()
    
    public var client: DropboxClient?
    private let defaults = UserDefaults.standard
    private var realmDatabase = CoreDataBase.shared
    private var isReadyContent : Bool = false
    private var contentCount = 0
    weak var delegate: DropBoxDelegateBlueProtocol?
    
    public func installDropBox() {
        struct DefaultStruct {
            static let noname = "string"
        }
        
        // clear for debug
//         clearAllThings()
        
        guard let refresh = self.defaults.value(forKey: KeysForDropBox_json.RefreshTokenSaveVarieble) as? String else {
            print("start resetting token operation")
            giveMePleaseReshreshToken(code: KeysForDropBoks.token) { refresh_token in
                if let rToken = refresh_token {
                    print(rToken)
                    self.defaults.setValue(rToken, forKey: KeysForDropBox_json.RefreshTokenSaveVarieble)
                    self.makeValidateAccessTokenDropBoxAnd(token: rToken) { validator in
                        if validator {
                            self.startFeatchAfterBlueValidatorToken(validate: validator)
                        } else {
                            self.makeValidateAccessTokenDropBoxAnd(token: KeysForDropBoks.refresh_token) { validator2 in
                                self.startFeatchAfterBlueValidatorToken(validate: validator2)
                            }
                        }
                    }
                }
            }
            self.makeValidateAccessTokenDropBoxAnd(token: KeysForDropBoks.refresh_token) { validator2 in
                self.startFeatchAfterBlueValidatorToken(validate: validator2)
            }
            return
        }
        print("\(refresh) add to ---> refresh_token")
        self.makeValidateAccessTokenDropBoxAnd(token: refresh) { validator in
            self.startFeatchAfterBlueValidatorToken(validate: validator)
        }
    }
    
    private func accessContentToApp() {
        struct DefaultStruct {
            static let noname = "string"
        }
        DispatchQueue.main.async {
            print(CoreDataBase.shared.categories.count, CoreDataBase.shared.mods.count)
        }
        NotificationCenter.default.post(name: Notification.Name("dropBoxIsReady"), object: nil)
    }
    
    private func startFeatchAfterBlueValidatorToken(validate : Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if validate {
            print("token valid")
            if defaults.value(forKey: "dataDidLoaded") == nil || (defaults.value(forKey: "dataDidLoaded") != nil) == true {
                featchBlueMods { dropData, contentIsReady  in
                    self.validateBeautifulContent(contentIsReady)
                    self.convertToLocalBlueDataBase(dictionary: dropData, type: .mods) { isCompleted in
                        self.validateBeautifulContent(isCompleted)
                    }
                }
                featchBeautifulCategories { categoryData, contentIsReady in
                    self.validateBeautifulContent(contentIsReady)
                    self.convertToLocalBlueDataBase(dictionary: categoryData, type: .category) { isCompleted in
                        self.validateBeautifulContent(isCompleted)
                    }
                }
                fetchModEditorBlueItems { dataEditor, contentIsReady in
                    self.validateBeautifulContent(contentIsReady)
                    self.convertToLocalBlueDataBase(dictionary: dataEditor, type: .editorItems) { isCompleted in
                        self.validateBeautifulContent(isCompleted)
                    }
                }
            } else {
                print("data in database")
                accessContentToApp()
            }
        } else {
            print("token has expired")
        }
    }
    
    
    private func validateBeautifulContent(_ bool: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if bool {
            contentCount += 1
        }
        if contentCount == 3 {
            defaults.set(true, forKey: "dataDidLoaded")
            print("operation completed \(contentCount)")
            accessContentToApp()
            contentCount = 0
        } else {
            print("operation not completed \(contentCount)")
        }
    }
    
    private func clearAllThings() {
        struct DefaultStruct {
            static let noname = "string"
        }
        defaults.set(false, forKey: "dataDidLoaded")
        defaults.set(0, forKey: "json_categories_data_count")
        defaults.set(0, forKey: "json_data_count")
        defaults.set(0, forKey: "json_editor_data_count")
        realmDatabase.clearBlueRealm()
    }
    
    private func convertToLocalBlueDataBase(dictionary: NSMutableDictionary, type: ModelForDropBoxItemsType, completion: @escaping (Bool) -> ()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch type {
        case .mods:
            if let dictionary: NSMutableDictionary = dictionary.object(forKey: type.getKey) as? NSMutableDictionary {
                if let items = dictionary.object(forKey: KeysForDropBox_json.Items) as? [ModelForDropBoxItems] {
                    for item in items {
                        let modItem = ModRealmModelElement()
                        modItem.id = UUID().uuidString
                        modItem.categoryName = item.category
                        modItem.modFilePath = item.file
                        modItem.modDescription = item.desc
                        modItem.modTitle = item.title
                        modItem.isNew = item.isNew
                        modItem.modImagePath = item.img
                        self.realmDatabase.saveBlueModsToRealmssss(mod: modItem)
                        print("\(type.getKey) save to database")
                    }
                    completion(true)
                } else {
                    print("errror items")
                }
            }
        case .category:
            if let dictionary: NSMutableDictionary = dictionary.object(forKey: type.getKey) as? NSMutableDictionary {
                if let categories = dictionary.object(forKey: KeysForDropBox_json.Categories) as? [ModelForDropBoxItemsCategory] {
                    for category in categories {
                        let categoryItem = CategoryRealmModelElement()
                        categoryItem.categoryName = category.category
                        categoryItem.categoryImagePath = "categories/" + category.categoryImage
                        self.realmDatabase.saveBlueCategoryToRealm(cat: categoryItem)
                        print(category.category, "category save to database")
                    }
                    completion(true)
                } else {
                    print("errror categories")
                }
            }
        case .editorItems:
            if let editorItems = dictionary.object(forKey: KeysForDropBox_json.EditorItems) as? [ModelDropBoxEditorSmallItems] {
                for item in editorItems {
                    let editorItem = EditorItemRealmModelElement()
                    editorItem.name = item.category
                    editorItem.id = UUID().uuidString
                    editorItem.imagePath = item.image
                    editorItem.category = item.category
                    editorItem.type = item.type
                    editorItem.tag = item.tag
                    self.realmDatabase.saveEditorBlueItem(mod: editorItem)
                }
                completion(true)
            } else {
                print("errror categories")
            }
        }
    }
    
    private func parseCategoriesAnd(json: [String : Any], mainKey: String, imageKey: String, titleKey: String) -> NSMutableDictionary {
        struct DefaultStruct {
            static let noname = "string"
        }
        let result: NSMutableDictionary = NSMutableDictionary()
        var categories: [ModelForDropBoxItemsCategory] = []
        if let modsCategory = json[mainKey] as? [[String : Any]] {
            for category in modsCategory {
                if let title = category[KeysForDropBox_json.categories_title] as? String, let image = category[KeysForDropBox_json.categories_img] as? String {
                    var newImg = image
                    if let range = image.range(of: "categories/") {
                        newImg.removeSubrange(range)
                    }
                    let category = ModelForDropBoxItemsCategory(category: title, categoryImage: newImg, type: ModelForDropBoxItemsType.category.getKey)
                    categories.append(category)
                    
                }
            }
            result.setValue(categories, forKey: KeysForDropBox_json.Categories)
        }
        return result
    }
    
    private func parseBeautifulMods(json: [String : Any], mainKey: String, fileKey: String, descKey: String, imageKey: String, titleKey: String, isNewKey: String) -> NSMutableDictionary {
        struct DefaultStruct {
            static let noname = "string"
        }
        let result: NSMutableDictionary = NSMutableDictionary()
        var items: [ModelForDropBoxItems] = []
        if let modsItems = json[mainKey] as? [String : Any] {
            for categoryName in modsItems {
                if let content = modsItems[categoryName.key.description] as? [[String : Any]] {
                    for item_content in content {
                        if let file = item_content[fileKey] as? String, let image = item_content[imageKey] as? String, let desc = item_content[descKey] as? String, let title = item_content[titleKey] as? String /*, let isNew = item_content[isNewKey] as? String*/ {
                            let item = ModelForDropBoxItems(title: title, desc: desc, category: categoryName.key.description, file: file, img: image, type: ModelForDropBoxItemsType.mods.getKey, isNew: "true")
                            items.append(item)
                        }
                    }
                }
            }
            result.setValue(items, forKey: KeysForDropBox_json.Items)
        }
        return result
    }
    
    private func fetchModEditorBlueItems(completion: @escaping (NSMutableDictionary, Bool) -> ()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        client?.files.download(path: KeysForDropBoks.modEditorFilePath).response(completionHandler: { response, error in
            let dropData: NSMutableDictionary = NSMutableDictionary()
            if let response = response {
                let fileContents = response.1
                do {
                    if fileContents.count != self.defaults.integer(forKey: "json_editor_data_count") {
                        self.defaults.set(fileContents.count, forKey: "json_editor_data_count")
                        print("when json new json_editor_data_count")
                    } else {
                        print("when json old json_editor_data_count")
                        completion(NSMutableDictionary(), true)
                        return
                    }
                    
                    let jsonFile = try JSONSerialization.jsonObject(with: fileContents, options: [])
                    if let itemsDictionary = jsonFile as? [String: Any] {
                        let categoryKeys = [
                            KeysForDropBox_json.robots_category,
                            KeysForDropBox_json.bakcgrounds_category,
                            KeysForDropBox_json.boatsAndShips_category,
                            KeysForDropBox_json.weapons_category
                        ]
                        
                        var editorItems: [ModelDropBoxEditorSmallItems] = []
                        
                        
                        for categoryKey in categoryKeys {
                            let categoryItems = self.parseEditorItems(json: itemsDictionary, categoryKey: categoryKey, imageKey: KeysForDropBox_json.mod_editor_img)
                            editorItems.append(contentsOf: categoryItems)
                        }
                        
                        dropData.setValue(editorItems, forKey: KeysForDropBox_json.EditorItems)
                        
                        completion(dropData, false)
                    } else {
                        completion(NSMutableDictionary(), false)
                    }
                } catch {
                    completion(NSMutableDictionary(), false)
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error)
                completion(NSMutableDictionary(), false)
            }
        })
        .progress({ progress in
            print("Downloading: ", progress)
        })
    }
    
    private func parseEditorItems(json: [String: Any], categoryKey: String, imageKey: String) -> [ModelDropBoxEditorSmallItems] {
        struct DefaultStruct {
            static let noname = "string"
        }
        var editorItems: [ModelDropBoxEditorSmallItems] = []
        
        if let categoryItems = json[categoryKey] as? [[String: Any]] {
            for category in categoryItems {
                if let image = category[imageKey] as? String, let tag = category["tag"] as? String {
                    let editorItem = ModelDropBoxEditorSmallItems(category: categoryKey, image: image, type: ModelForDropBoxItemsType.editorItems.getKey, tag: tag)
                    print("🎃 \(categoryKey): \(editorItem)")
                    editorItems.append(editorItem)
                }
            }
            
        }
        
        return editorItems
    }
    
    private func featchBeautifulCategories(completion: @escaping (NSMutableDictionary, Bool) ->()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        client?.files.download(path: KeysForDropBoks.categoriesFilePath).response(completionHandler: { response, error in
            let dropData: NSMutableDictionary = NSMutableDictionary()
            if let response = response {
                let fileContents = response.1
                do {
                    if fileContents.count != self.defaults.integer(forKey: "json_categories_data_count") {
                        self.defaults.set(fileContents.count, forKey: "json_categories_data_count")
                        print("when json new json_categories_data_count")
                        //                        self.realmDatabase.clearRealm()
                    } else {
                        print("when json old json_categories_data_count")
                        completion(NSMutableDictionary(), true)
                        return
                    }
                    
                    let jsonFile = try JSONSerialization.jsonObject(with: fileContents, options: [])
                    if let itemsDictionary = jsonFile as? [String : Any] {
                        let categories = self.parseCategoriesAnd(json: itemsDictionary, mainKey: KeysForDropBox_json.categories_array, imageKey: KeysForDropBox_json.categories_img, titleKey: KeysForDropBox_json.categories_title)
                        dropData.setValue(categories, forKey: KeysForDropBox_json.Categories)
                        completion(dropData, false)
                    } else {
                        completion(NSMutableDictionary(), false)
                    }
                } catch {
                    completion(NSMutableDictionary(), false)
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error)
                completion(NSMutableDictionary(), false)
            }
        })
        .progress({ progress in
            print("Downloading: ",progress)
        })
    }
    
    private func featchBlueMods(completion: @escaping (NSMutableDictionary, Bool) ->()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        client?.files.download(path: KeysForDropBoks.contentFilePath).response(completionHandler: { response, error in
            let dropData: NSMutableDictionary = NSMutableDictionary()
            if let response = response {
                let fileContents = response.1
                do {
                    if fileContents.count != self.defaults.integer(forKey: "json_data_count") {
                        self.defaults.set(fileContents.count, forKey: "json_data_count")
                        print("when json new")
                        //                        self.realmDatabase.clearRealm()
                    } else {
                        print("when json old")
                        completion(NSMutableDictionary(), true)
                        return
                    }
                    
                    let jsonFile = try JSONSerialization.jsonObject(with: fileContents, options: [])
                    if let itemsDictionary = jsonFile as? [String : Any] {
                        
                        let mods = self.parseBeautifulMods(json: itemsDictionary, mainKey: KeysForDropBox_json.mod_array, fileKey: KeysForDropBox_json.mod_file, descKey: KeysForDropBox_json.mod_desc, imageKey: KeysForDropBox_json.mod_img, titleKey: KeysForDropBox_json.mod_title, isNewKey: KeysForDropBox_json.mod_new)
                        
                        dropData.setValue(mods, forKey: KeysForDropBox_json.Mods)
                        completion(dropData, false)
                    } else {
                        completion(NSMutableDictionary(), false)
                    }
                } catch {
                    completion(NSMutableDictionary(), false)
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error)
                completion(NSMutableDictionary(), false)
            }
        })
        .progress({ progress in
            print("Downloading: ", progress)
        })
    }
    
    private func makeValidateAccessTokenDropBoxAnd(token : String,completion: @escaping(Bool)->()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.giveMeBloodyTokenBy(refresh_token: token) { access_token in
            if let aToken = access_token {
                self.client = DropboxClient(accessToken:aToken)
                print("token updated !!! \(aToken),\(String(describing: self.client))")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    private func giveMePleaseReshreshToken(code: String, completion: @escaping (String?) -> ()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let username = KeysForDropBoks.appkey
        let password = KeysForDropBoks.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let parameters: Data = "code=\(code)&grant_type=authorization_code".data(using: .utf8)!
        let url = URL(string: KeysForDropBoks.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                ContentMagicUnLocker.shared.isLostConnection = true
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completion(responseJSON[KeysForDropBox_json.RefreshTokenSaveVarieble] as? String)
            } else {
                print("error")
            }
        }
        task.resume()
    }
    
    private func giveMeBloodyTokenBy(refresh_token: String, completion: @escaping (String?) -> ()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let loginString = String(format: "%@:%@", KeysForDropBoks.appkey, KeysForDropBoks.appSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let parameters: Data = "refresh_token=\(refresh_token)&grant_type=refresh_token".data(using: .utf8)!
        let url = URL(string: KeysForDropBoks.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completion(responseJSON["access_token"] as? String)
            } else {
                print("error")
            }
        }
        task.resume()
    }
    
    public func getBloodyImageURLFromDropBox(img: String, completion: @escaping (String?) -> ()){
        struct DefaultStruct {
            static let noname = "string"
        }
        self.client?.files.getTemporaryLink(path: "/\(img)").response(completionHandler: { responce, error in
            if let link = responce {
                completion(link.link)
            } else {
                completion(nil)
            }
        })
    }
    
    public func getBloodyFileUrlFromDropbox(path: String, completion: @escaping (String?) -> ()){
        struct DefaultStruct {
            static let noname = "string"
        }
        self.client?.files.getTemporaryLink(path: "/\(path)").response(completionHandler: { responce, error in
            if let link = responce {
                completion(link.link)
            } else {
                completion(nil)
            }
        })
    }
    
    public func downloadBloodyFileBy(urlPath: URL, completion: @escaping (String?, Error?) -> Void) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let fileURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let urlForDestination = fileURL.appendingPathComponent(urlPath.lastPathComponent)
        if FileManager().fileExists(atPath: urlForDestination.path) {
            print("File already exists [\(urlForDestination.path)]")
            completion(urlForDestination.path, nil)
        } else {
            let configuration = URLSessionConfiguration.default
            let urlSession = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: urlPath)
            let httpMethod = "GET"
            request.httpMethod = httpMethod
            let urlDataTask = urlSession.dataTask(with: request, completionHandler: { data, response, error in
                if error != nil {
                    completion(urlForDestination.path, error)
                } else {
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            if let data = data {
                                if let _ = try? data.write(to: urlForDestination, options: Data.WritingOptions.atomic) {
                                    completion(urlForDestination.path, error)
                                } else {
                                    completion(urlForDestination.path, error)
                                }
                            } else {
                                completion(urlForDestination.path, error)
                            }
                        }
                    }
                }
            })
            urlDataTask.resume()
        }
    }
    
    func downloadBloodyFileBy(urlPath: String, completion: @escaping (Data?) -> Void) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.client?.files.download(path:  "/\(urlPath)").response(completionHandler: { responce, error in
            if let responce = responce {
                completion(responce.1)
            }else {
                completion(nil)
            }
        })
    }
}
