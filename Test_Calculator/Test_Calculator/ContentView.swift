//
//  ContentView.swift
//  Test_Calculator
//
//  Created by SeungKyu on 2023/02/08.
//

import SwiftUI

struct ContentView: View {
    
    enum ButtonType:String {
        case first,second,third,forth,fifth,sixth,seventh,eighth,nineth,zero
        case dot, equal, plus, minus, multiple, devide
        case percent, opposite, clear
        
        var ButtonDisplayName: String {
            switch self{
            case .first :
                return "1"
            case .second :
                return "2"
            case .third :
                return "3"
            case .forth :
                return "4"
            case .fifth :
                return "5"
            case .sixth :
                return "6"
            case .seventh :
                return "7"
            case .eighth :
                return "8"
            case .nineth :
                return "9"
            case .zero :
                return "0"
            case .dot :
                return "."
            case .equal :
                return "="
            case .plus :
                return "+"
            case .minus :
                return "-"
            case .multiple :
                return "x"
            case .devide :
                return "/"
            case .percent :
                return "%"
            case .opposite :
                return "+/-"
            case .clear :
                return "C"
            default:
                return "?"
            }
        }
        
        var backgroundcolor: Color {
            switch self{
            case .first,.second,.third,.forth,.fifth,.sixth,.seventh,.eighth,.nineth,.zero,.dot :
                return Color("NumberButton")
            case  .equal, .plus, .minus, .multiple, .devide:
                return Color(.orange)
            case .percent, .opposite, .clear:
                return Color(.gray)
            }
        }
        
        var forgroundcolor: Color {
            switch self{
            case .first,.second,.third,.forth,.fifth,.sixth,.seventh,.eighth,.nineth,.zero,.dot
                ,.equal, .plus, .minus, .multiple, .devide
                :
                return Color(.white)
            case .percent, .opposite, .clear:
                return Color(.black)
            }
        }
    }
    @State private var totalNumber: String = "0"
    @State var TempNumber :Int = 0
    @State var operatorType: ButtonType = .clear
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .devide],
        [.seventh, .eighth, .nineth, .multiple],
        [.forth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text(totalNumber)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                }
                
                ForEach(buttonData,id: \.self){ line in
                    HStack {
                        ForEach(line, id: \.self){ item in
                            Button {
                                
                                
                                if totalNumber == "0" || totalNumber == "Error"{
                                    if item == .clear {
                                        totalNumber = "0"
                                    }
                                    else if item == .plus ||
                                                item == .minus ||
                                                item == .multiple ||
                                                item == .devide ||
                                                item == .equal{
                                        totalNumber = "Error"
                                    }
                                    else{
                                        totalNumber = item.ButtonDisplayName
                                    }
                                }
                                
                                else{
                                    if item == .clear {
                                        totalNumber = "0"
                                    }
                                    else if item == .plus{
                                        TempNumber = Int(totalNumber) ?? 0
                                        operatorType = .plus
                                        totalNumber = "0"
                                    }
                                    else if item == .multiple{
                                        TempNumber = Int(totalNumber) ?? 0
                                        operatorType = .multiple
                                        totalNumber = "0"
                                    }
                                    else if item == .minus{
                                        TempNumber = Int(totalNumber) ?? 0
                                        operatorType = .minus
                                        totalNumber = "0"
                                    }
                                    else if item == .devide{
                                        TempNumber = Int(totalNumber) ?? 0
                                        operatorType = .plus
                                        totalNumber = "0"
                                    }
                                    else if item == .equal{
                                        if operatorType == .plus{
                                            totalNumber = String((Int(totalNumber) ?? 0) + TempNumber)
                                        }
                                        else if operatorType == .multiple{
                                            totalNumber = String((Int(totalNumber) ?? 0) * TempNumber)
                                        }
                                        else if operatorType == .minus{
                                            totalNumber = String(TempNumber - (Int(totalNumber) ?? 0))
                                        }
                                    }
                                    else{
                                        totalNumber += item.ButtonDisplayName
                                    }
                                }
                                
                            }label: {
                                Text(item.ButtonDisplayName)
                                    .frame(width: calculatorButtonWidth(button: item),height: calculatorButtonHeight(button: item))
                                    .background(item.backgroundcolor)
                                    .cornerRadius(40)
                                    .foregroundColor(item.forgroundcolor)
                                    .font(.system(size: 33))
                                    .bold()
                            }
                        }
                    }
                }
            }
        }
    }
    private func calculatorButtonWidth(button buttonType: ButtonType) -> CGFloat {
        switch buttonType {
        case .zero:
            return ((UIScreen.main.bounds.width - 5*10) / 4) * 2
        default:
            return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    
    private func calculatorButtonHeight(button: ButtonType) -> CGFloat {
        return (UIScreen.main.bounds.width - 5*10) / 4
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
