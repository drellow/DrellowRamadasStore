# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

this.CartAction = (element) ->
  that = this
  this.element = element


  this.element.click(() ->
    $.ajax({
      url: '/cart',
      type: 'PUT',
      data: "id=" + that.element.data('id') + "&ac=destroy",
      success: () ->
        Cart.update()
    })
  )

this.CartObject = (element) ->
  that = this
  that.element = $(element)
  that.cart = null

  that.update = () ->
    $.getJSON(
      "/cart",
      (data) ->
        that.cart = data

        that.populate()
    )

  that.populate = () ->
    that.element.empty()
    that.element.append("Your Cart:<br><br>")

    ol = $("<ol></ol>")

    $(that.cart.unique_items).each(() ->
      if this.count > 1
        li = $("<li>" + this.name + " (" + this.count + ")</li>").data('id', this.id)
      else
        li = $("<li>" + this.name + "</li>").data('id', this.id)

      new CartAction(li)
      ol.append(li)
    )

    ol.append("<br><br>Total: $" + that.cart.total_price)

    that.element.append(ol)

  return