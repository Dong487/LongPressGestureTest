//
//  ContentView.swift
//  LongPressGesture
//
//  Created by DONG SHENG on 2021/7/9.
//

import SwiftUI

struct ContentView: View {
    @State var isComplete = false
    @State var isSuccess = false
    
    var body: some View {
        VStack{
            
            Rectangle()
                .fill(isSuccess ? Color.green.opacity(0.7) :  Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack{
                Text("長按＋＋")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange.opacity(0.7))
                    .cornerRadius(10)
                    
                                        //長按最小持續時間:     位移限制(超出範圍停止動作):
                    .onLongPressGesture(minimumDuration: 2, maximumDistance: 50) { (isPressing) in
                        //點擊後 -> 最小持續時間
                        if isPressing{
                                            //淡入淡出   動作時間:(最好與min Duration 相同)
                            withAnimation(.easeInOut(duration: 2)){
                                isComplete = true
                            }
                        } else {
                            
                            //延遲0.01秒後判斷 如果長按的時間沒有達到  則不改變Bool狀態
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                if !isSuccess{
                                    withAnimation(.easeInOut){
                                        isComplete = false
                                    }
                                }
                            }
                        }
                
                    } perform: {
                        //最小持續時間完 後
                        withAnimation(.easeInOut){
                            isSuccess = true
                        }
                    }

                
                Text("重置")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.pink.opacity(0.8))
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
