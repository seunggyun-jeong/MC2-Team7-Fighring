//
//  CouponView.swift
//  MC2-Team7-Fighring
//
//  Created by yun on 2023/05/08.
//
import SwiftUI

struct CouponView: View {
    
    @State var isLock: [Bool] = [true, true, false, false, false, false]
    
    @State var completeSix = false
    @State private var isActive:Bool = true
    @State private var letter:String = ""
    
    
    var days: ClosedRange<Int>
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    var body: some View {
        VStack{
            LazyVGrid(columns: columns) {
                
                ForEach(days, id: \.self) { day in
                    
                    NavigationLink {
                        LoverHome()
                    } label: {
                        ZStack{
                            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                .cornerRadius(15)
                                .frame(width: 150, height: 150)
                            Text("Day \(day)")
                                .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $isLock[3]){
                    LockView()}
            }
            Divider()
                .frame(width: 200)
                .background(.black)
                .padding(.top)
            
            if isActive{
                Button {
                    completeSix = true
                } label: {
                    Text("공유하기")
                }
            }else{
                Text("count/6")
                
            }
        }
        .sheet(isPresented: $completeSix) {
            LetterView()
        }
    }
}

struct CouponView_Previews: PreviewProvider {
    static var previews: some View {
        CouponView(days: (1...6))
    }
}
