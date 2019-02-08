import UIKit
import RxSwift
import RxCocoa

let disposeBag:DisposeBag = DisposeBag()

let model = VHObservableTextfieldViewModel(value: "", placeHolder: "Enter email", instruction: "Enter something")

let lengthModel = VHObservableLabelModel(labelText: "Character length should be 8") { (inputString) -> Bool in
    return inputString.count > 7
}

let specialCharacterModel = VHObservableLabelModel(labelText: "Special Characters") { (inputString) -> Bool in
    guard inputString.count > 0 else {return false}
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    return inputString.rangeOfCharacter(from: characterset.inverted) != nil
}

let captialCharacterModel = VHObservableLabelModel(labelText: "Special Characters") { (inputString) -> Bool in
    guard inputString.count > 0 else {return false}
    let characterset = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    return inputString.rangeOfCharacter(from: characterset) != nil
}

let lowerCaseCharacterModel = VHObservableLabelModel(labelText: "Lower Case") { (inputString) -> Bool in
    guard inputString.count > 0 else {return false}
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
    return inputString.rangeOfCharacter(from: characterset) != nil
}

let numberModel = VHObservableLabelModel(labelText: "Numbers") { (inputString) -> Bool in
    guard inputString.count > 0 else {return false}
    let decimalCharacters = CharacterSet.decimalDigits
    let decimalRange = inputString.rangeOfCharacter(from: decimalCharacters)
    return decimalRange != nil
}

model.validationObservables = [lengthModel, specialCharacterModel, captialCharacterModel, lowerCaseCharacterModel, numberModel]

lengthModel.validationObservable.subscribe(onNext: { (isValid) in
    print("isValid from lengthModel: \(isValid)")
}).disposed(by: disposeBag)

specialCharacterModel.validationObservable.subscribe(onNext: { (isValid) in
    print("isValid from specialCharacterModel: \(isValid)")
}).disposed(by: disposeBag)

captialCharacterModel.validationObservable.subscribe(onNext: { (isValid) in
    print("isValid from captialCharacterModel: \(isValid)")
}).disposed(by: disposeBag)

lowerCaseCharacterModel.validationObservable.subscribe(onNext: { (isValid) in
    print("isValid from lowerCaseCharacterModel: \(isValid)")
}).disposed(by: disposeBag)

numberModel.validationObservable.subscribe(onNext: { (isValid) in
    print("isValid from numberModel: \(isValid)")
}).disposed(by: disposeBag)

model.value.asDriver()
    .skip(1)
    .drive(onNext: { (inputValue) in
    print("\(inputValue)")
        if let validationObservables = model.validationObservables {
            for validationObservable in validationObservables {
                if let isValid = validationObservable.validationFunction?(inputValue) {
                    validationObservable.validationObservable.onNext(isValid)
                }
            }
        }
}).disposed(by: disposeBag)

model.value.accept("Password123!")
model.value.accept("asadf")
model.value.accept("CAPS")
model.value.accept("lower")
model.value.accept("123")
model.value.accept("")//none
model.value.accept("01234567")//length
