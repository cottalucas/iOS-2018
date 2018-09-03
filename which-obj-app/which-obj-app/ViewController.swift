//
//  ViewController.swift
//  which-obj-app
//
//  Created by Lucas Cotta on 9/3/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK - IBOutlets
    @IBOutlet weak var photoFromUser: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegates
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageFromPicker = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoFromUser.image = imageFromPicker
            
            //Convert image to ciimage type used on CoreML
            guard let ciimage = CIImage(image: imageFromPicker) else {
                fatalError("Could not convert image!")
            }
            //Detect method
            detect(image: ciimage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //ML
    func detect(image: CIImage){
        //Build the model into a container
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Model could not be constructed")
        }
        
        //Request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Error processing the request")
            }
            if let bestResult = results.first {
                self.navigationItem.title = String(bestResult.identifier.split(separator: ",").first!)
            }
        }
        
        //Handler + Perform
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
}

