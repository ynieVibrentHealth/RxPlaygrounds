import Foundation
import RxSwift
import RxCocoa

public class VHObservableLabelModel {
    public var labelText:String
    public var validationObservable:PublishSubject<Bool>
    public var validationFunction:((_ inputString:String) -> Bool)?
    public init(labelText:String, validationFunction:((_ inputString:String) -> Bool)?) {
        self.labelText = labelText
        self.validationObservable = PublishSubject()
        self.validationFunction = validationFunction
    }
}

