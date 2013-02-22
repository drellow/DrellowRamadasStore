# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
    that.element.append("Your Cart:")

    ol = $("<ol></ol>")

    $(that.cart.items).each(() ->
      ol.append("<li>" + this.name + "</li>")
    )

    that.element.append(ol);

  return