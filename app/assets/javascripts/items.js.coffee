# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

this.Item = (id, name, price) ->
  this.id = id
  this.name = name
  this.price = price

this.Item.all = []

this.Item.grabAll = (callback) ->
  $.getJSON(
    "/items",
    (data) ->
      $(data).each(() ->
        Item.all.push(this)
      )

      callback() if callback
  )

this.ItemAction = (element) ->
  that = this
  this.element = element


  this.element.click(() ->
    $.ajax({
      url: '/cart',
      type: 'PUT',
      data: "id=" + that.element.data('id'),
      success: () ->
        Cart.update()
    })
  )

this.Carrousel = (element, cart) ->
  that = this
  this.element = $(element)

  this.getItems = () ->
    that.element.width($(document).width() - 280)

    $(window).resize(() ->
      that.element.width($(document).width() - 280)
    )
    Item.grabAll(that.populate)

  this.populate = () ->
    ol = $("<ol></ol>")

    $(Item.all).each(() ->
      li = $("<li>" + this.name + "</li>").data('id', this.id)

      li.width($(document).width() - 280)

      $(window).resize(() ->
        li.width($(document).width() - 280)
      )

      new ItemAction(li)

      ol.append(li)
      return
    )

    ol.width(($(document).width() - 280) * Item.all.length)

    $(window).resize(() ->
      ol.width(($(document).width() - 280) * Item.all.length)
    )

    that.element.append(ol)

  return