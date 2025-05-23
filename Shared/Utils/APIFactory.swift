//
//  APIFactory.swift
//  SyncExtension
//
//  Created by Robert Garcia on 7/8/23.
//

import Foundation
import InternxtSwiftCore

enum APIFactoryError: Error {
    case MissingLegacyToken
}

var CLIENT_NAME = "drive-desktop"
func getVersion() -> String {
    guard let version = Bundle.main.releaseVersionNumber else {
        return "NO_VERSION"
    }
    guard let buildNumber = Bundle.main.buildVersionNumber else {
        return "NO_BUILD_NUMBER"
    }
    
    return "\(version).\(buildNumber)"
}


struct APIFactory {
    
    
    
    static var Network: NetworkAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let networkAuth = configLoader.getNetworkAuth()
        return NetworkAPI(baseUrl: config.NETWORK_API_URL, basicAuthToken: networkAuth!, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static var NetworkWorkspace: NetworkAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let networkAuth = configLoader.getNetworkAuthWorkspace()
        return NetworkAPI(baseUrl: config.NETWORK_API_URL, basicAuthToken: networkAuth!, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static var DriveNew: DriveAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let token = configLoader.getAuthToken() ?? "MISSING_TOKEN"
        
        return DriveAPI(baseUrl: config.DRIVE_NEW_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static var DriveWorkspace: DriveAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let token = configLoader.getAuthToken() ?? "MISSING_TOKEN"
        let workspaceHeader = configLoader.getWorkspaceCredentials()?.tokenHeader
        return DriveAPI(baseUrl: config.DRIVE_NEW_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(),workspaceHeader: workspaceHeader , gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static var Drive: DriveAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let token = configLoader.getLegacyAuthToken() ?? "MISSING_TOKEN"
        
        return DriveAPI(baseUrl: config.DRIVE_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static var Photos: PhotosAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let token = configLoader.getAuthToken() ?? "MISSING_TOKEN"
        
        return PhotosAPI(baseUrl: config.PHOTOS_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion())
    }
    
    static var Trash: TrashAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let token = configLoader.getAuthToken() ?? "MISSING_TOKEN"
        
        return TrashAPI(baseUrl: config.DRIVE_NEW_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static var TrashWorkspace: TrashAPI {
        let configLoader = ConfigLoader()
        
        let config = configLoader.get()
        let token = configLoader.getAuthToken() ?? "MISSING_TOKEN"
        let workspaceHeader = configLoader.getWorkspaceCredentials()?.tokenHeader

        return TrashAPI(baseUrl: config.DRIVE_NEW_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(),workspaceHeader: workspaceHeader, gatewayHeader: config.HEADER_KEY_GATEWAY)
    }

    static var Backup: BackupAPI {
        let configLoader = ConfigLoader()

        let config = configLoader.get()
        let token = configLoader.getLegacyAuthToken() ?? "MISSING_TOKEN"

        return BackupAPI(baseUrl: config.DRIVE_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static func getBackupsClient() -> BackupAPI {
        return BackupNew
    }

    static var BackupNew: BackupAPI {
        let configLoader = ConfigLoader()

        let config = configLoader.get()
        let token = configLoader.getAuthToken() ?? "MISSING_TOKEN"

        return BackupAPI(baseUrl: config.DRIVE_NEW_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static var Payment: DriveAPI {
        let configLoader = ConfigLoader()

        let config = configLoader.get()
        let token = configLoader.getAuthToken() ?? "MISSING_TOKEN"

        return DriveAPI(baseUrl: config.GATEWAY_API_URL, authToken: token, clientName: CLIENT_NAME, clientVersion: getVersion(), gatewayHeader: config.HEADER_KEY_GATEWAY)
    }
    
    static func getNewBackupsClient() -> BackupAPI {
        return BackupNew
    }
}
