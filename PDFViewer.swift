import SwiftUI
import PDFKit

struct PDFViewer: View {
    var url: URL

    var body: some View {
        PDFKitRepresentedView(url: url)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        loadPDF(pdfView: pdfView, from: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Update the view if needed
    }

    private func loadPDF(pdfView: PDFView, from url: URL) {
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        } else {
            print("Failed to load PDF document from URL: \(url)")
        }
    }
}
