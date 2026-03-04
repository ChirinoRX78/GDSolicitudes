//
//  PreviewController.swift
//  GDSolicitudes
//
//  Created by TI on 27/02/26.
//

import SwiftUI
import QuickLook
import UIKit

struct PreviewController: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> UINavigationController {
        let preview = QLPreviewController()
        preview.dataSource = context.coordinator
        let nav = UINavigationController(rootViewController: preview)
        preview.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: context.coordinator,
            action: #selector(Coordinator.compartir)
        )
        return nav
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(url: url)
    }
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let url: URL
        init(url: URL) {
            self.url = url
        }
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            1
        }
        func previewController(_ controller: QLPreviewController,
            previewItemAt index: Int) -> QLPreviewItem {
                url as NSURL
        }
        @objc func compartir() {
            let activity = UIActivityViewController(
                activityItems: [url],
                applicationActivities: nil
            )
            UIApplication.shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first?
                .rootViewController?
                .present(activity, animated: true)
        }
    }
}
