//
//  PizzaOrder.swift
//  Golnaz_Pizza
//
//  Created by Golnaz Chehrazi on 2023-06-05.
//

import Foundation
class PizzaOrder: ObservableObject{
    @Published var customerInfo : (String, String)
    var pizzaSize : Int
    var pizzaType : Int
    var quantity : Int
    var couponApplied : Bool
    
    var subTotal: Double{
        if(self.couponApplied){
            return Double(quantity) * 5.0
        }
        else
        {
            //veg pizza type = 0
            if(pizzaType == 0){
                switch(pizzaSize)
                {
                    //small =0 , medium = 1 , large = 2
                case 0:
                    return Double(self.quantity) * 5.99
                case 1:
                    return Double(self.quantity) * 7.99
                case 2:
                    return Double(self.quantity) * 10.99
                default:
                    return 0
                    
                }
            }
            //non-veg pizza type = 1
            else{
                //small = 0 , medium = 1 , large = 2
                switch(pizzaSize)
                {
                case 0:
                    return Double(self.quantity) * 6.99
                case 1:
                    return Double(self.quantity) * 8.99
                case 2:
                    return Double(self.quantity) * 12.99
                default:
                    return 0
                    
                }
            }
        }
    }
    
    var Tax : Double{
        return 0.13 * self.subTotal
    }
    
    var finalCost : Double{
        return self.subTotal + Tax
    }
    
    init()
    {
        self.customerInfo = (customerName: "unknown", phoneNumber: "unknown")
        pizzaType = 1
        pizzaSize = 1
        quantity = 1
        couponApplied = false
    }
    
    init(customerName: String, customerPhoneNumber: String, pizzaSize: Int, pizzaType: Int, quantity: Int, couponApplied: Bool) {
        self.customerInfo = (cusstomerName: customerName, phoneNumber: customerPhoneNumber)
        
        self.pizzaSize = pizzaSize
        self.pizzaType = pizzaType
        self.quantity = quantity
        self.couponApplied = couponApplied
    }
}
