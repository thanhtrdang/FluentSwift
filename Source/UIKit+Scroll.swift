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
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
}

private extension TPKeyboardAvoidingScrollView {
    func setup() {
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
let kCalculatedContentPadding:CGFloat = 10;
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
        if keyboardRect.isEmpty {
            return
        }
        
        guard let firstResponder = findFirstResponderBeneathView(self) else {
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
            if contentSize.equalTo(CGSize.zero) {
                contentSize = calculatedContentSizeFromSubviewFrames()
            }
        }
        
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let options = UIViewAnimationOptions(rawValue: UInt(curve))
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [weak self] in
            if let actualSelf = self {
                actualSelf.contentInset = actualSelf.contentInsetForKeyboard()
                let viewableHeight = actualSelf.bounds.size.height - actualSelf.contentInset.top - actualSelf.contentInset.bottom
                let point = CGPoint(x: actualSelf.contentOffset.x, y: actualSelf.idealOffsetForView(firstResponder, viewAreaHeight: viewableHeight))
                actualSelf.setContentOffset(point, animated: false)
                
                actualSelf.scrollIndicatorInsets = actualSelf.contentInset
                actualSelf.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let rectNotification = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRect = self.convert(rectNotification.cgRectValue , from: nil)
        if keyboardRect.isEmpty {
            return
        }
        
        if !state.keyboardVisible {
            return
        }
        
        state.keyboardRect = .zero
        state.keyboardVisible = false
        
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let options = UIViewAnimationOptions(rawValue: UInt(curve))
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [weak self] in
            if let actualSelf = self {
                if actualSelf is TPKeyboardAvoidingScrollView {
                    let state = actualSelf.state
                    actualSelf.contentSize = state.priorContentSize
                    actualSelf.contentInset = state.priorInset
                    actualSelf.scrollIndicatorInsets = state.priorScrollIndicatorInsets
                    actualSelf.isPagingEnabled = state.priorPagingEnabled
                    actualSelf.layoutIfNeeded()
                }
            }
            
        }, completion: nil)
    }
    
    fileprivate func updateFromContentSizeChange() {
        if state.keyboardVisible {
            state.priorContentSize = self.contentSize
        }
    }
    
    fileprivate func focusNextTextField() -> Bool {
        guard let firstResponder = findFirstResponderBeneathView(self) else {
            return false
        }
        guard let view = findNextInputViewAfterView(firstResponder, beneathView: self) else {
            return false
        }
        Timer.scheduledTimer(timeInterval: 0.1, target: view, selector: #selector(becomeFirstResponder), userInfo: nil, repeats: false)
        
        return true
    }
    
    @objc fileprivate func scrollToActiveTextField() {
        if !state.keyboardVisible {
            return
        }
        
        let visibleSpace = self.bounds.size.height - self.contentInset.top - self.contentInset.bottom
        
        let idealOffset = CGPoint(x: 0,
                                  y: idealOffsetForView(findFirstResponderBeneathView(self), viewAreaHeight: visibleSpace))
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(0 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            [weak self] in
            self?.setContentOffset(idealOffset, animated: true)
        }
    }
    
    //Helper
    fileprivate func findFirstResponderBeneathView(_ view:UIView) -> UIView? {
        for childView in view.subviews {
            if childView.responds(to: #selector(getter: isFirstResponder)) && childView.isFirstResponder {
                return childView
            }
            let result = findFirstResponderBeneathView(childView)
            if result != nil {
                return result
            }
        }
        return nil
    }
    
    fileprivate func updateContentInset() {
        if state.keyboardVisible {
            self.contentInset = contentInsetForKeyboard()
        }
    }
    
    fileprivate func calculatedContentSizeFromSubviewFrames() -> CGSize {
        let wasShowingVerticalScrollIndicator = showsVerticalScrollIndicator
        let wasShowingHorizontalScrollIndicator = showsHorizontalScrollIndicator
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        var rect = CGRect.zero
        
        for view in self.subviews {
            rect = rect.union(view.frame)
        }
        
        rect.size.height += kCalculatedContentPadding
        showsVerticalScrollIndicator = wasShowingVerticalScrollIndicator
        showsHorizontalScrollIndicator = wasShowingHorizontalScrollIndicator
        
        return rect.size
    }
    
    fileprivate func idealOffsetForView(_ view:UIView?,viewAreaHeight:CGFloat) -> CGFloat {
        var offset: CGFloat = 0.0
        let subviewRect =  view != nil ? view!.convert(view!.bounds, to: self) : CGRect.zero
        
        var padding = (viewAreaHeight - subviewRect.height)/2
        if padding < kMinimumScrollOffsetPadding {
            padding = kMinimumScrollOffsetPadding
        }
        
        offset = subviewRect.origin.y - padding - self.contentInset.top
        
        if offset > (contentSize.height - viewAreaHeight) {
            offset = contentSize.height - viewAreaHeight
        }
        
        if offset < -contentInset.top {
            offset = -contentInset.top
        }
        
        return offset
    }
    
    fileprivate func contentInsetForKeyboard() -> UIEdgeInsets {
        var newInset = contentInset;
        
        let keyboardRect = state.keyboardRect
        newInset.bottom = keyboardRect.size.height - max(keyboardRect.maxY - bounds.maxY, 0)
        
        return newInset
    }
    
    fileprivate func viewIsValidKeyViewCandidate(_ view:UIView) -> Bool {
        if view.isHidden || !view.isUserInteractionEnabled {
            return false
        }
        
        if view is UITextField {
            if (view as! UITextField).isEnabled {
                return true
            }
        }
        
        if view is UITextView {
            if (view as! UITextView).isEditable {
                return true
            }
        }
        
        return false
    }
    
    fileprivate func findNextInputViewAfterView(_ priorView:UIView, beneathView view:UIView, candidateView bestCandidate: inout UIView?) {
        let priorFrame = convert(priorView.frame, to: priorView.superview)
        let candidateFrame = bestCandidate == nil ? CGRect.zero : convert(bestCandidate!.frame, to: bestCandidate!.superview)
        
        var bestCandidateHeuristic = -sqrt(candidateFrame.origin.x*candidateFrame.origin.x + candidateFrame.origin.y*candidateFrame.origin.y) + (Float(fabs(candidateFrame.minY - priorFrame.minY)) < Float.ulpOfOne ? 1e6 : 0)
        
        for childView in view.subviews {
            if viewIsValidKeyViewCandidate(childView) {
                let frame = self.convert(childView.frame, to: view)
                let heuristic = -sqrt(frame.origin.x*frame.origin.x + frame.origin.y*frame.origin.y)
                    + (Float(fabs(frame.minY - priorFrame.minY)) < Float.ulpOfOne ? 1e6 : 0)
                
                if childView != priorView && (Float(fabs(frame.minY - priorFrame.minY)) < Float.ulpOfOne
                    && frame.minX > priorFrame.minX
                    || frame.minY > priorFrame.minY)
                    && (bestCandidate == nil || heuristic > bestCandidateHeuristic) {
                    bestCandidate = childView
                    bestCandidateHeuristic = heuristic
                }
            } else {
                findNextInputViewAfterView(priorView, beneathView: view, candidateView: &bestCandidate)
            }
        }
    }
    
    fileprivate func findNextInputViewAfterView(_ priorView:UIView,beneathView view:UIView) -> UIView? {
        var candidate:UIView?
        findNextInputViewAfterView(priorView, beneathView: view, candidateView: &candidate)
        return candidate
    }
    
    @objc fileprivate func assignTextDelegateForViewsBeneathView(_ obj: AnyObject) {
        func processWithView(_ view: UIView) {
            for childView in view.subviews {
                if childView is UITextField || childView is UITextView {
                    initializeView(childView)
                } else {
                    assignTextDelegateForViewsBeneathView(childView)
                }
            }
        }
        
        if let timer = obj as? Timer, let view = timer.userInfo as? UIView {
            processWithView(view)
        }
        else if let view = obj as? UIView {
            processWithView(view)
        }
    }
    
    fileprivate func initializeView(_ view: UIView) {
        if let textField = view as? UITextField, let delegate = self as? UITextFieldDelegate, textField.delegate !== delegate {
            textField.delegate = delegate
            
            if textField.returnKeyType == .default {
                let otherView = findNextInputViewAfterView(view, beneathView: self)
                textField.returnKeyType = otherView != nil ? .next : .done
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
