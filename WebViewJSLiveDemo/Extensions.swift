//
//  Extensions.swift
//  WebViewJSLiveDemo
//
//  Created by chantil on 2022/11/23.
//

import UIKit

extension UIView {
    func autolayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UITextView {
    func autoCorrection(_ type: UITextAutocorrectionType) -> Self {
        autocorrectionType = type
        return self
    }

    func autoCapitalization(_ type: UITextAutocapitalizationType) -> Self {
        autocapitalizationType = type
        return self
    }

    func editable(_ editable: Bool) -> Self {
        isEditable = editable
        return self
    }
}

extension UILabel {
    func numberOfLines(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }

    func updateText(_ text: String?) -> Self {
        self.text = text
        return self
    }
}
