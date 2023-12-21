import Foundation
import PDFKit

class ViewModel: ObservableObject {
    @Published var pdfDocumentURL: URL?

    func handleIncomingPDF(url: URL) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentDirectory.appendingPathComponent(url.lastPathComponent)

        // Check if the file is from the app's Inbox directory (browser download)
        if url.path.contains("/Inbox/") {
            // Handling files from the browser
            do {
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                try fileManager.copyItem(at: url, to: destinationURL)
                DispatchQueue.main.async {
                    self.pdfDocumentURL = destinationURL
                }
            } 
            catch {
                print("File copy error: \(error)")
            }
        } 
        else {
            // Handling files from the iPhone storage
            if url.startAccessingSecurityScopedResource() {
                defer {
                    url.stopAccessingSecurityScopedResource()
                }

                // Copy the file to the app's directory if needed
                do {
                    if fileManager.fileExists(atPath: destinationURL.path) {
                        try fileManager.removeItem(at: destinationURL)
                    }
                    try fileManager.copyItem(at: url, to: destinationURL)
                    DispatchQueue.main.async {
                        self.pdfDocumentURL = destinationURL
                    }
                } 
                catch {
                    print("File copy error: \(error)")
                }
            } 
            else {
                print("Couldn't access the resource at URL: \(url)")
            }
        }
    }
}
