//
//  CheckForUpdatesView.swift
//  InternxtDesktop
//
//  Created by Robert Garcia on 19/9/23.
//

import SwiftUI
import Sparkle


final class CheckForUpdatesViewModel: ObservableObject {
    @Published var canCheckForUpdates = false

    init(updater: SPUUpdater) {
        updater.publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
    }
}

struct CheckForUpdatesView: View {
    @ObservedObject private var checkForUpdatesViewModel: CheckForUpdatesViewModel
    private let updater: SPUUpdater
    
    init(updater: SPUUpdater) {
        self.updater = updater
        
        // Create our view model for our CheckForUpdatesView
        self.checkForUpdatesViewModel = CheckForUpdatesViewModel(updater: updater)
    }
    
    var body: some View {
        AppButton(title: "SETTINGS_CHECK_FOR_UPDATES", onClick: askUserToDeleteApp, type: .secondary, size: .MD)//.disabled(!checkForUpdatesViewModel.canCheckForUpdates)
    }
    
    func askUserToDeleteApp() {
        let openPanel = NSOpenPanel()
        openPanel.title = "Selecciona la aplicación a eliminar"
        openPanel.message = "Selecciona la aplicación que deseas eliminar"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.allowedFileTypes = ["app"]

        if openPanel.runModal() == .OK, let selectedApp = openPanel.url {
            deleteApp(at: selectedApp.path)
        } else {
            print("El usuario canceló la selección.")
        }
    }
    
    func deleteApp(at path: String) {
        let fileManager = FileManager.default

        do {
            try fileManager.removeItem(atPath: path)
            print("Aplicación eliminada con éxito.")
        } catch {
            print("Error al eliminar la aplicación: \(error)")
        }
    }
}

