import Foundation
import AVFoundation

@available(iOS 17.0, *)
class MicManager: ObservableObject {
    @Published var isMicPermissionGranted: Bool = false
    
    init() {
        updateMicPermissionStatus()
    }
    
    func requestMicPermission() async {
        let granted = await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission { allowed in
                continuation.resume(returning: allowed)
            }
        }
        DispatchQueue.main.async {
            self.isMicPermissionGranted = granted
            self.updateMicPermissionStatus()
        }
    }
    
    func updateMicPermissionStatus() {
        let permission = AVAudioApplication.shared.recordPermission
        DispatchQueue.main.async {
            switch permission {
            case .granted:
                self.isMicPermissionGranted = true
            case .denied, .undetermined:
                self.isMicPermissionGranted = false
            @unknown default:
                self.isMicPermissionGranted = false
            }
        }
    }
}
