import SwiftUI

struct AIView: View {
    @State private var inputImage: UIImage?
    @State private var classificationLabel = "Nessuna immagine selezionata"
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showingActionSheet = false

    private let imageClassifier = ImageClassifier()

    var body: some View {
        VStack(spacing: 20) {
            Text("Hai completato la challenge?")
                .font(.largeTitle)
                .fontWeight(.bold)

            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .shadow(radius: 5)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 300, height: 300)
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
            }

            Text(classificationLabel)
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                self.showingActionSheet = true
            }) {
                HStack {
                    Image(systemName: "camera.fill")
                    Text("Carica Immagine")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 3)
            }
            .padding(.horizontal)
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: self.$inputImage, sourceType: self.sourceType)
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Scegli un'opzione"), buttons: [
                .default(Text("Fotocamera")) {
                    self.sourceType = .camera
                    self.showingImagePicker = true
                },
                .default(Text("Libreria Foto")) {
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                .cancel()
            ])
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        classifyImage(image: inputImage)
    }

    private func classifyImage(image: UIImage) {
        do {
            try self.imageClassifier.classifyImage(image) { result in
                switch result {
                case .success(let classification):
                    DispatchQueue.main.async {
                        // Formatta il risultato per visualizzarlo
                        let formattedResult = classification
                            .map { "\($0.key) (\(String(format: "%.2f", $0.value * 100))%)" }
                            .joined(separator: "\n")
                        self.classificationLabel = "Piatto: \(classification.first?.key ?? "Non riconosciuto")"
                        print("Classificazione:\n\(formattedResult)")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.classificationLabel = "Errore nella classificazione"
                        print("Errore: \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.classificationLabel = "Errore nell'elaborazione"
                print("Errore: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    AIView()
}
