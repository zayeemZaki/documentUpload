import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Group {
            if let pdfUrl = viewModel.pdfDocumentURL {
                PDFViewer(url: pdfUrl)
            } else {
                Text("No PDF selected")
            }
        }
    }
}
