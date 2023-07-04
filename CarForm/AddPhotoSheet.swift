
import SwiftUI

struct AddPhotoSheet: View {
    
    @State private var image: Image?
    @State private var isShowingImagePicker = false

    var body: some View {

        VStack {
            if image != nil {
                image!
                    .resizable()
                    .frame(maxWidth: 90, maxHeight: 60)
                    .scaledToFit()
            }

            HStack {
                Group {
                    Text("Car photo")
                    Spacer()
                    Button(action: {
                        isShowingImagePicker.toggle()

                    }) {
                        Image(systemName: "plus.app")
                    }
                }
            }
            .foregroundColor(Color("BG"))

            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: $image, isShowingImagePicker: $isShowingImagePicker)
            })
        }
    }

    func loadImage() {
        guard let inputImage = image else { return }
        // Perform any additional processing of the selected image here.
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Binding var isShowingImagePicker: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update necessary.
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isShowingImagePicker: $isShowingImagePicker)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: Image?
        @Binding var isShowingImagePicker: Bool

        init(image: Binding<Image?>, isShowingImagePicker: Binding<Bool>) {
            _image = image
            _isShowingImagePicker = isShowingImagePicker
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let uiImage = info[.originalImage] as? UIImage else { return }
            image = Image(uiImage: uiImage)
            isShowingImagePicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShowingImagePicker = false
        }
    }
}


//
//يمكنك تحقيق ذلك باستخدام مصفوفة لتخزين الصور المحددة وعرضها جميعًا في VStack. يمكنك تحديث `AddPhotoSheet` بالطريقة التالية:
//
//- أولاً، قم بتعريف مصفوفة `images` لتخزين الصور المحددة:
//
//```swift
//@State private var images: [Image] = []
//```
//
//- ثانيًا، في `body`، قم بتحديث `VStack` ليعرض جميع الصور في `images`:
//
//```swift
//VStack {
//    if !images.isEmpty {
//        ScrollView(.horizontal) {
//            HStack(spacing: 10) {
//                ForEach(images, id: \.self) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                }
//            }
//        }
//    }
//
//    HStack {
//        Group {
//            Text("Car photo")
//            Spacer()
//            Button(action: {
//                isShowingImagePicker.toggle()
//            }) {
//                Image(systemName: "plus.app")
//            }
//        }
//    }
//    .foregroundColor(Color("BG"))
//
//    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage, content: {
//        ImagePicker(images: $images, isShowingImagePicker: $isShowingImagePicker)
//    })
//}
//```
//
//- ثالثًا، في `ImagePicker`، قم بتحديث `Coordinator` لتحميل جميع الصور المحددة وإضافتها إلى `images`:
//
//```swift
//class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    @Binding var images: [Image]
//    @Binding var isShowingImagePicker: Bool
//
//    init(images: Binding<[Image]>, isShowingImagePicker: Binding<Bool>) {
//        _images = images
//        _isShowingImagePicker = isShowingImagePicker
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let uiImage = info[.originalImage] as? UIImage else { return }
//        images.append(Image(uiImage: uiImage))
//        isShowingImagePicker = false
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        isShowingImagePicker = false
//    }
//}
//```
//
//- وأخيرًا، يجب تحديث دالة `loadImage` لتعالج المصفوفة بدلاً من صورة واحدة:
//
//```swift
//func loadImage() {
//    guard !images.isEmpty else { return }
//    // Perform any additional processing of the selected images here.
//}
//```
//
//بهذا، يمكنك اختيار عدة صور في ImagePicker وسيتم عرضها جميعًا في VStack في AddPhotoSheet.
