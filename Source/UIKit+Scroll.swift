//
//  UIKit+Scroll.swift
//  FluentSwift
//
//  Created by Thanh Dang on 6/4/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ScrollView
public class TPKeyboardAvoidingScrollView: UIScrollView, UITextFieldDelegate, UITextViewDelegate {
    override public var contentSize: CGSize {
        didSet {
            updateFromContentSizeChange()
        }
    }
    
    override public var frame: CGRect {
        didSet {
            updateContentInset()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func contentSizeToFit() {
        self.contentSize = calculatedContentSizeFromSubviewFrames()
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), object: self)
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        findFirstResponderBeneathView(self)?.resignFirstResponder()
        super.touchesEnded(touches, with: event)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !self.focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), object: self)
        self.perform(#selector(assignTextDelegateForViewsBeneathView(_:)), with: self, afterDelay: 0.1)
    }
}

extension TPKeyboardAvoidingScrollView {
    fileprivate func setup() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillChangeFrame,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: .UITextViewTextDidBeginEditing,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: .UITextFieldTextDidBeginEditing,
                                               object: nil)
    }
}

// MARK: - Process Event
let kCalculatedContentPadding:CGFloat = 20;
let kMinimumScrollOffsetPadding:CGFloat = 20;

extension UIScrollView {
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let rectNotification = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardRect = convert(rectNotification.cgRectValue , from: nil)
        if keyboardRect.isEmpty || !keyboardRect.intersects(bounds) {
            //            state.keyboardVisible = false
            return
        }
        
        guard let firstResponder = self.findFirstResponderBeneathView(self) else {
            return
        }
        
        if state.ignoringNotifications && (firstResponder.frame.origin.y + kCalculatedContentPadding < keyboardRect.origin.y) {
            return
        }
        
        state.keyboardRect = keyboardRect
        
        if !state.keyboardVisible {
            state.priorInset = contentInset
            state.priorScrollIndicatorInsets = scrollIndicatorInsets
            state.priorPagingEnabled = isPagingEnabled
        }
        
        state.keyboardVisible = true
        isPagingEnabled = false
        
        if self is TPKeyboardAvoidingScrollView {
            state.priorContentSize = contentSize
            if contentSize == .zero {
                contentSize = calculatedContentSizeFromSubviewFrames()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            var duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
            if duration == 0 {
                duration = 0.25
            }
            var curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0
            if curve == 0 {
                curve = 7
            }
            
            let options = UIViewAnimationOptions(rawValue: UInt(curve))
            
            self.state.keyboardAnimationInProgress = true
            
            UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [unowned self] in
                self.contentInset = self.contentInsetForKeyboard()
                self.scrollIndicatorInsets = self.contentInset
                self.layoutIfNeeded()
                
                let viewableHeight = self.bounds.size.height - self.contentInset.top - self.contentInset.bottom
                let point = CGPoint(x: self.contentOffset.x, y: self.idealOffsetForView(firstResponder, viewAreaHeight: viewableHeight))
                self.setContentOffset(point, animated: false)
                })
            {[unowned self] finished in
                if finished {
                    self.state.keyboardAnimationInProgress = false
                }
            }
        }
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let rectNotification = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRect = self.convert(rectNotification.cgRectValue, from: nil)
        if keyboardRect.isEmpty && !state.keyboardAnimationInProgress {
            return
        }
        
        if state.ignoringNotifications || !state.keyboardVisible {
            return
        }
        
        state.keyboardRect = .zero
        state.keyboardVisible = false
        
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let options = UIViewAnimationOptions(rawValue: UInt(curve))
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [unowned self] in
            let state = self.state
            if self is TPKeyboardAvoidingScrollView {
                self.contentSize = self.state.priorContentSize
            }
            self.contentInset = state.priorInset
            self.scrollIndicatorInsets = state.priorScrollIndicatorInsets
            self.isPagingEnabled = state.priorPagingEnabled
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    fileprivate func updateContentInset() {
        if state.keyboardVisible {
            contentInset = contentInsetForKeyboard()
        }
    }
    
    fileprivate func updateFromContentSizeChange() {
        if state.keyboardVisible {
            state.priorContentSize = self.contentSize
            contentInset = contentInsetForKeyboard()
        }
    }
    
    fileprivate func focusNextTextField() -> Bool {
        guard let firstResponder = findFirstResponderBeneathView(self) else {
            return false
        }
        guard let view = findNextInputViewAfterView(firstResponder, beneathView: self) else {
            return false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.state.ignoringNotifications = true
            view.becomeFirstResponder()
            self.state.ignoringNotifications = false
        }
        
        return true
    }
    
    @objc fileprivate func scrollToActiveTextField() {
        if !state.keyboardVisible {
            return
        }
        
        guard let firstResponder = findFirstResponderBeneathView(self) else {
            return
        }
        
        state.ignoringNotifications = true
        
        let visibleSpace = self.bounds.size.height - self.contentInset.top - self.contentInset.bottom
        
        let idealOffset = CGPoint(x: contentOffset.x,
                                  y: idealOffsetForView(firstResponder, viewAreaHeight: visibleSpace))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.setContentOffset(idealOffset, animated: true)
            self.state.ignoringNotifications = false
        }
    }
    
    //Helper
    fileprivate func findFirstResponderBeneathView(_ view:UIView) -> UIView? {
        for subview in view.subviews {
            if subview.responds(to: #selector(getter: isFirstResponder)) && subview.isFirstResponder {
                return subview
            }
            let result = findFirstResponderBeneathView(subview)
            if result != nil {
                return result
            }
        }
        return nil
    }
    
    
    fileprivate func calculatedContentSizeFromSubviewFrames() -> CGSize {
        let wasShowingVerticalScrollIndicator = showsVerticalScrollIndicator
        let wasShowingHorizontalScrollIndicator = showsHorizontalScrollIndicator
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        var rect = CGRect.zero
        
        for subview in subviews {
            rect = rect.union(subview.frame)
        }
        
        rect.size.height += kCalculatedContentPadding
        showsVerticalScrollIndicator = wasShowingVerticalScrollIndicator
        showsHorizontalScrollIndicator = wasShowingHorizontalScrollIndicator
        
        return rect.size
    }
    
    fileprivate func idealOffsetForView(_ view: UIView, viewAreaHeight: CGFloat) -> CGFloat {
        var offset: CGFloat = 0.0
        var padding: CGFloat = 0.0
        
        if view.conforms(to: UITextInput.self),
            let textInput = view as? UITextInput,
            let caretPosition = textInput.selectedTextRange?.start {
            let caretRect = convert(textInput.caretRect(for: caretPosition), from: view)
            
            padding = (viewAreaHeight - caretRect.size.height) / 2
            
            if padding < kMinimumScrollOffsetPadding {
                padding = kMinimumScrollOffsetPadding
            }
            
            offset = caretRect.origin.y - padding - self.contentInset.top
        } else {
            let subviewRect = view.convert(view.bounds, to: self)
            padding = (viewAreaHeight - subviewRect.size.height) / 2
            
            if padding < kMinimumScrollOffsetPadding {
                padding = kMinimumScrollOffsetPadding
            }
            
            offset = subviewRect.origin.y - padding - self.contentInset.top
        }
        
        offset = min(offset, contentSize.height - viewAreaHeight - contentInset.top)
        offset = max(offset, -contentInset.top)
        
        return offset
    }
    
    
    fileprivate func contentInsetForKeyboard() -> UIEdgeInsets {
        var newInset = contentInset;
        
        let keyboardRect = state.keyboardRect
        newInset.bottom = keyboardRect.size.height - max(keyboardRect.maxY - bounds.maxY, 0)
        
        return newInset
    }
    
    
    fileprivate func viewIsValidKeyViewCandidate(_ view: UIView) -> Bool {
        if viewHiddenOrUserInteractionNotEnabled(view) {
            return false
        }
        
        if view is UITextField && (view as! UITextField).isEnabled {
            return true
        }
        
        if view is UITextView && (view as! UITextView).isEditable {
            return true
        }
        
        return false
    }
    
    fileprivate func viewHiddenOrUserInteractionNotEnabled(_ view: UIView) -> Bool {
        var testingView: UIView? = view
        while (testingView != nil) {
            if (testingView!.isHidden || !testingView!.isUserInteractionEnabled) {
                return true
            }
            testingView = testingView!.superview
        }
        return false
    }
    
    fileprivate func findNextInputViewAfterView(_ priorView:UIView, beneathView view:UIView, candidateView bestCandidate: inout UIView?) {
        let priorFrame = convert(priorView.frame, from: priorView.superview)
        let candidateFrame = bestCandidate == nil ? CGRect.zero : convert(bestCandidate!.frame, from: bestCandidate!.superview)
        var bestCandidateHeuristic = nextInputViewHeuristicForViewFrame(candidateFrame)
        
        for subview in view.subviews {
            if viewIsValidKeyViewCandidate(subview) {
                let frame = convert(subview.frame, from: view)
                let heuristic = nextInputViewHeuristicForViewFrame(frame)
                if subview != priorView
                    && (fabs(frame.minY - priorFrame.midY) < CGFloat.ulpOfOne
                        && frame.minX > priorFrame.minX
                        || frame.minY > priorFrame.minY)
                    && (bestCandidate == nil || heuristic > bestCandidateHeuristic) {
                    
                    bestCandidate = subview
                    bestCandidateHeuristic = heuristic
                }
            } else {
                findNextInputViewAfterView(priorView, beneathView: subview, candidateView: &bestCandidate)
            }
        }
    }
    
    fileprivate func findNextInputViewAfterView(_ priorView:UIView,beneathView view:UIView) -> UIView? {
        var candidate:UIView?
        findNextInputViewAfterView(priorView, beneathView: view, candidateView: &candidate)
        return candidate
    }
    
    fileprivate func nextInputViewHeuristicForViewFrame(_ frame: CGRect) -> CGFloat {
        return  (-frame.origin.y * 1000.0)  // Prefer elements closest to top (most important)
            + (-frame.origin.x)         // Prefer elements closest to left
    }
    
    
    @objc fileprivate func assignTextDelegateForViewsBeneathView(_ view: UIView) {
        for subview in view.subviews {
            if subview is UITextField || subview is UITextView {
                initializeView(subview)
            } else {
                assignTextDelegateForViewsBeneathView(subview)
            }
        }
    }
    
    fileprivate func initializeView(_ view: UIView) {
        if let textField = view as? UITextField {
            if textField.delegate == nil {
                textField.delegate = self as? UITextFieldDelegate
            }
            
            if textField.returnKeyType == .default {
                textField.returnKeyType = .next
            }
        }
    }
}

// MARK: - Internal object observer
fileprivate class TPKeyboardAvoidingState: NSObject {
    var priorInset = UIEdgeInsets.zero
    var priorScrollIndicatorInsets = UIEdgeInsets.zero
    
    var keyboardVisible = false
    var keyboardRect = CGRect.zero
    
    var priorContentSize = CGSize.zero
    var priorPagingEnabled = false
    
    var ignoringNotifications = false
    var keyboardAnimationInProgress = false
}

extension UIScrollView {
    fileprivate struct AssociatedKeysKeyboard {
        static var DescriptiveName = "KeyBoard_DescriptiveName"
    }
    
    fileprivate var state: TPKeyboardAvoidingState {
        var state = objc_getAssociatedObject(self, &AssociatedKeysKeyboard.DescriptiveName) as? TPKeyboardAvoidingState
        if state == nil {
            state = TPKeyboardAvoidingState()
            objc_setAssociatedObject(self, &AssociatedKeysKeyboard.DescriptiveName, state, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        return state!
    }
}
