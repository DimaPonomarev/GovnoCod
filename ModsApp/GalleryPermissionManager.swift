import Photos
import UIKit



class PermissionForGalleryManager {
    
    static let shared = PermissionForGalleryManager()
    
    func lets_permissionToGallery(completion: @escaping (Bool) -> ()) {
        struct DefaultStruct {
            static let noname = "string"
        }
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .notDetermined, .restricted, .limited:
                    print("notDetermined restricted limited")
                    completion(false)
                case .denied:
                    print("denied")
                    completion(false)
                case .authorized:
                    print("authorized")
                    completion(true)
                @unknown default:
                    print("default authorized")
                    completion(false)
                }
            }
        } else if PHPhotoLibrary.authorizationStatus() == .denied {
            completion(false)
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            completion(true)
        }
    }
    
}
