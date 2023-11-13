//
//  UserReceipt.swift
//  Golnaz_Pizza
//
//  Created by Golnaz Chehrazi on 2023-06-05.
//

import SwiftUI

struct UserReceipt: View {
    @EnvironmentObject var newOrder : PizzaOrder
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "rectangle.and.hand.point.up.left").resizable().frame(width: 32, height: 32).foregroundColor(Color.blue)
                Text("receipt").textCase(.uppercase).bold().font(.title).foregroundColor(Color.blue)
            }
            
            List{
                Section{
                    Text("Name: \(newOrder.customerInfo.0)")
                    Text("Phone Number: \(newOrder.customerInfo.1)")
                }header : {
                    Text("Customer Information")}
                Section{
                    switch(newOrder.pizzaType){
                    case 0:
                        Text("Pizza Type: Vegetarian")
                    case 1:
                        Text("Pizza Type: Non-Vegetarian")
                    default :
                        Text("Pizza Type: unknown")
                    }
                    //Text("Pizza Type: \(newOrder.pizzaType)")
                    switch(newOrder.pizzaSize){
                    case 0:
                        Text("Pizza Size: Small")
                    case 1:
                        Text("Pizza Size: Medium")
                    case 2:
                        Text("Pizza Size: Large")
                    default :
                        Text("Pizza Size: unknown")
                    }
                    Text("Quantity: \(newOrder.quantity)")
                    HStack{
                        Text("Coupon Applied: ")
                        if(newOrder.couponApplied){
                            Text("YES").foregroundColor(Color.green)
                        }   else{
                            Text("NO").foregroundColor(Color.red)
                        }
                    }
                }header : {
                    Text("Order Information")}
                Section{
                    Text("Subtotal: \(String(format: "%.2f", newOrder.subTotal))")
                    Text("Tax: \(String(format: "%.2f", newOrder.Tax))")
                    Text("Final Cost: \(String(format: "%.2f", newOrder.finalCost))")
                }footer:{
                    Text("Enjoy Your Food! :)")}
            }
        }
        .padding()
        Spacer()
    }
}

struct UserReceipt_Previews: PreviewProvider {
    static var previews: some View {
        UserReceipt()
    }
}
