import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
}

struct SafariViewPreviews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://www.hoyolab.com/home")!)
    }
}
