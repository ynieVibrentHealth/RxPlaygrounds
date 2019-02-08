import Foundation
import RxSwift
import RxCocoa

public class VHObservableTextfieldViewModel {
    public var isValid:BehaviorRelay<Bool>
    public var value:BehaviorRelay<String>
    public let placeHolder:String
    public let instructionText:String
    public var errorMessage:String?
    public var validationObservables:[VHObservableLabelModel]?
    public let isEditing:Bool = false
    public var didInteractWith:Bool = false
    
    public init(value:String, placeHolder:String, instruction:String, isValid:Bool = false) {
        self.isValid = BehaviorRelay(value: isValid)
        self.value = BehaviorRelay(value: value)
        self.instructionText = instruction
        self.placeHolder = placeHolder
    }
}
