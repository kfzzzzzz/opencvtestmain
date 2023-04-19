//
//  inputTextView.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 4/19/23.
//

import Foundation
import UIKit
import SnapKit

class inputTextView: UITextView,UITextViewDelegate {
    
    var maxHeight:CGFloat=60.atScale()//定义最大高度
    
    override init(frame:CGRect, textContainer:NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        //textview的一些设置
        self.delegate=self
        self.layer.borderColor = UIColor.pink2().cgColor
        self.layer.borderWidth=0.5
        self.layer.cornerRadius=5
        self.layer.masksToBounds=true
        self.font = UIFont.PFRegular(16.atScale())
        self.returnKeyType = .send
        self.autocapitalizationType = .none  //自动大写样式
        self.autocorrectionType = .no //自动更正样式
    }
    
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_textView:UITextView) {
        //获取frame值
        let frame = _textView.frame
        //定义一个constrainSize值用于计算textview的高度
        let constrainSize=CGSize(width:frame.size.width,height:CGFloat(MAXFLOAT))
        //获取textview的真实高度
        var size = _textView.sizeThatFits(constrainSize)
        //如果textview的高度大于最大高度高度就为最大高度并可以滚动，否则不能滚动
        if size.height>=maxHeight{
            size.height=maxHeight
            _textView.isScrollEnabled=true
        }else{
            _textView.isScrollEnabled=false
        }
        //重新设置textview的高度
        _textView.frame.size.height=size.height
    }

}

