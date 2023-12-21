//
//  documentUploadApp.swift
//  documentUpload
//
//  Created by Zayeem on 12/20/23.
//

import SwiftUI
import UIKit
import PDFKit

@main
struct DocumentUploadApp: App {
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .onOpenURL { url in
                    if url.pathExtension == "pdf" {
                        viewModel.handleIncomingPDF(url: url)
                    }
                }
        }
    }
}
