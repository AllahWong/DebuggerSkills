//
//  ViewController.swift
//  DebuggerSkills
//
//  Created by Allah on 2019/3/13.
//  Copyright © 2019年 Allah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var didReachSelectedHeight: Bool = false
    var count: Int = 5
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        jump()

    }

    @IBOutlet weak var label: UILabel!
    @IBAction func buttonIsPressed(_ sender: Any) {
        
        //-[UILabel setText:]处的断点触发
        //        UIKitCore`-[UILabel setText:]:
        //        ->  0x107843fbd <+0>:  pushq  %rbp
        //        0x107843fbe <+1>:  movq   %rsp, %rbp
        //        0x107843fc1 <+4>:  movq   0x82b098(%rip), %rsi      ; "_setText:"
        //        0x107843fc8 <+11>: popq   %rbp
        //        0x107843fc9 <+12>: jmpq   *0x44d4e1(%rip)           ; (void *)0x00000001030cbd80: objc_msgSend
        
        //obj_msgsend 第一个参数是消息的接收者，第二个参数是selector，第三个参数是传入方法的第一个参数
        //po $arg1 第一个参数的寄存器
//        (lldb) po $arg1
//        <UILabel: 0x7fe0de611c10; frame = (166 118; 113 21); text = 'Label'; opaque = NO; autoresize = RM+BM; userInteractionEnabled = NO; layer = <_UILabelLayer: 0x600003fec000>>
//
//        (lldb) po $arg2
//        4797937789
//此时看不到内容是因为LLDB不会自动知道这些参数的类型，因此某些情况需要进行类型转换
//        (lldb) po (SEL)$arg2
//        "setText:"
//
//        (lldb) po $arg3
//        990
        print("\(count)")
        label.text = "990"
        count += 1
        print("2\(count)")

        jump()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(3)) {
            self.jumpCompleted()
        }
    }
    func jump() {
        ViewController.testFuncP()
        if didReachSelectedHeight{
            //Xcode->Behaviors->Edit Behaviors->Running->Pauses->Show tab named Debugger in ..这个设置可以在调试的时候多出一个Debugger 选项卡
            //表达式(lldb) e didReachSelectedHeight=true 可以在调试中修改didReachSelectedHeight的值而无须修改代码
            print("didReachSelectedHeight yes")
        }
        else{
            print("didReachSelectedHeight no")
        }
    }
    
    func jumpCompleted()  {
        //        breakpoint set --one-shot true --name "-[UILabel setText:]"
//        命令为breakpoint set， 参数为--one-shot true，这个一次性断点是一个临时断点，一旦触发后就会被自动删除，给它起一个有意义的名字
        print("jumpCompleted")

    }
    
    static func testFuncP(){
        
    }
    
}

