package lesson2_variables

fun main(){
    var numbersOfWorkers = 200
    val numbersOfOrders = 75
    val thanksForOrders = "Спасибо за покупку, приходите ещё"

    //println("Количество работников: $numbersOfWorkers")

    numbersOfWorkers -= 1

    println("Количество работников: $numbersOfWorkers")
    println("Количество заказов: $numbersOfOrders")
    println(thanksForOrders)
}