import SwiftUI
import CoreML
import Vision
import ImageIO

class ImageClassifier {

    // Errore personalizzato per la classificazione
    enum ClassificationError: Error {
        case modelLoadingFailed(String)
        case imageProcessingFailed(String)
        case classificationFailed(String)
    }

    // MARK: - Modello VNCoreMLModel
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            /*
             Carica il modello di classificazione.
             Sostituisci "YourModelName" con il nome del tuo file .mlmodel.
            */

            // 1. Crea una configurazione per il modello.
            let configuration = MLModelConfiguration()
            
            // 2. Istanzia il modello usando la configurazione (la nuova sintassi corretta).
            let coreMLModel = try MyImageClassifier(configuration: configuration).model
            
            // 3. Crea il modello Vision dal modello Core ML.
            let model = try VNCoreMLModel(for: coreMLModel)
            
            let request = VNCoreMLRequest(model: model) { request, error in
                // Questa closure viene eseguita al completamento della classificazione
            }
            
            // L'immagine verrà scalata per adattarsi all'input del modello
            request.imageCropAndScaleOption = .centerCrop
            return request
            
        } catch {
            // Se il caricamento del modello fallisce, l'app non può funzionare.
            // Un fatalError è appropriato in questo scenario di setup.
            fatalError("Impossibile caricare il modello di ML: \(error)")
        }
    }()

    // MARK: - Funzione di Classificazione
    
    /// Crea una richiesta di classificazione per un'immagine e ne restituisce i risultati.
    /// - Parameters:
    ///   - image: L'immagine `UIImage` da classificare.
    ///   - completion: Una closure che viene eseguita al termine, con il risultato o un errore.
    func classifyImage(_ image: UIImage, completion: @escaping (Result<[String: Float], ClassificationError>) -> Void) {
        
        // Converte UIImage in CIImage
        guard let ciImage = CIImage(image: image) else {
            completion(.failure(.imageProcessingFailed("Impossibile creare CIImage da UIImage.")))
            return
        }

        // Crea un handler per l'immagine
        // L'orientamento è importante per ottenere risultati accurati
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        // Esegue la richiesta di classificazione
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([self.classificationRequest])
                
                // Estrae i risultati
                guard let observations = self.classificationRequest.results as? [VNClassificationObservation] else {
                    completion(.failure(.classificationFailed("Nessun risultato di classificazione.")))
                    return
                }
                
                // Mappa i risultati in un dizionario [Label: Confidence]
                let classifications = observations
                    .filter { $0.confidence > 0.0 } // Filtra per confidenza (opzionale)
                    .reduce(into: [String: Float]()) { (dict, observation) in
                        dict[observation.identifier] = observation.confidence
                    }
                
                completion(.success(classifications))
                
            } catch {
                completion(.failure(.classificationFailed("Errore durante l'esecuzione della richiesta: \(error.localizedDescription)")))
            }
        }
    }
}
