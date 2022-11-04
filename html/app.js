let currentOrderNumber = 1;

$(document).ready(function() {
    $("#orders__container").hide();
    $(".recipe__container").hide();

    window.addEventListener('message', function(event) {
        let data = event.data;

        if (data.action === "openOrders") {
            $("#orders__container").show();
        }
        else if (data.action === "closeOrders") {
            $("#orders__container").hide();
        }

        if (data.action == "createOrders") {
            for (let i = 0; i < Math.round(Math.random() * (50 - 25) + 25); i++) {
                let itemId = Math.floor(Math.random() * data.possibleOrders.length);
                AddOrder(data.possibleOrders[itemId].name, data.possibleOrders[itemId].price, data.possibleOrders[itemId].recipe, currentOrderNumber);
                currentOrderNumber++;
            }
        }

        if (data.action == "completeOrder") {
            $(`#orderId${data.orderNumber}`).hide();
        }

    });
});

function closeMenu() {
    $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
}

function AddOrder(ItemName, Price, Recipe, OrderNumber) {
    $("#orders__list__item").append(`<li class="list__item" id="orderId${OrderNumber}"><div class="order__item"><h3 class="order__item__number">Order Number: ${OrderNumber}</h3><h3 class="order__item__name">Name: ${ItemName}</h3><h3 class="order__item__price">Price: ${Price.toString()}</h3></div>`);
    $(`#orderId${currentOrderNumber}`).attr('recipe', Recipe)

    $(`#orderId${currentOrderNumber}`).click(function () {
        $('#recipe__list__item').empty();
        $('.recipe__container').show();

        let recipe = Recipe;

        for (let i in recipe)
        {
            $("#recipe__list__item").append(`<li class="recipe__item">${i}: ${recipe[i]}</li>`);
        }
    })

    $(`#orderId${currentOrderNumber}`).contextmenu(function () {
        let orderNumber = OrderNumber
        $.post(`https://${GetParentResourceName()}/completeOrder`, JSON.stringify({
            orderNumber: orderNumber,
            itemName: ItemName,
        }))
    })

    $('#exitRecipe').click(function () {
        $('.recipe__container').hide();
    })
}