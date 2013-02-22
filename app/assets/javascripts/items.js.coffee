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
      data: "id=" + that.element.data('id') + "&ac=add",
      success: () ->
        Cart.update()
    })
  )

this.Carrousel = (element, cart) ->
  that = this
  this.element = $(element)
  this.interval = null
  this.direction = '-=300'

  this.getItems = () ->
    that.element.width($(window).width() - 280)

    $(window).resize(() ->
      that.element.width($(window).width() - 280)
    )
    Item.grabAll(that.populate)


  this.start = () ->
    that.interval = setInterval(() ->
      distance = Math.abs(parseInt(that.element.find("ol").css('left')))
      olSize = that.element.find("ol").width()
      carrouselSize = that.element.width()

      if (distance >= olSize - carrouselSize) && (that.direction == '-=300')
        that.direction = '+=300'

      if (distance <= 0) && (that.direction == '+=300')
        that.direction = '-=300'

      that.element.find("ol").animate({
        left: that.direction
        }, 300, 'swing')
    , 1000)

  this.populate = () ->
    ol = $("<ol></ol>")

    $(Item.all).each(() ->
      li = $("<li></li>").data('id', this.id)

      image = $("<img src='/photos/" + this.id + "'>")
      title = $("<div class='label title'>" + this.name + "</div>")
      price = $("<div class='label'>$" + this.price + "</div>")

      li.append(image)
      li.append(title)
      li.append(price)

      rand = () ->
        return Math.floor(Math.random() * 255)

      li.css('background', 'rgb(' + rand() + ',' + rand() + ',' + rand() + ')')

      # li.width($(window).width() - 280)

      # $(window).resize(() ->
      #   li.width($(window).width() - 280)
      # )

      new ItemAction(li)

      ol.append(li)
      return
    )

    ol.width(300 * Item.all.length)

    # $(window).resize(() ->
    #   ol.width(($(window).width() - 280) * Item.all.length)
    # )

    that.element.append(ol)

    that.start()
    that.element.mouseover(() ->
      clearInterval(that.interval)
    )
    that.element.mouseleave(() ->
      that.start()
    )

  return