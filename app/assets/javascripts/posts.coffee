# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  decode = (text) -> $('<textarea />').html(text).text()
  urls = $('.post').map -> $(@).data('url')

  $('.posts').sortable
    cursor: 'move'
    change: -> $('.save_page').css(display: 'block')
    items: "> div.post"

  $('.post').on 'click', ->
    $(@).addClass 'editing'
    $(@).find('.url_box').show().find('.url').select()

  $('.url_box').on 'submit', ->
    url = encodeURIComponent $(@).find('.url').val()
    post_container = $(@).parents('.post')
    $.ajax
      method: "GET"
      dataType: 'json'
      url: "/posts"
      data: url: url
      success: (post) ->
        post_container.removeClass 'empty editing'
        post_container.data('url', url)
        post_container.find('img').attr('src', post.img)
        post_container.find('h3').html(decode post.headline)
        $('.save_page').css(display: 'block')
      error: ->
        alert "Something went wrong fetching that post"

    $(@).parents('.editing').removeClass 'editing'
    $(@).hide()
    false

  $('.url_box .cancel').on 'click', ->
    $(@).parents('.editing').removeClass 'editing'
    $(@).parents('.url_box').hide()
    false

  $('.save_page').on 'click', ->
    urls = $('.post').map -> $(@).data('url')
    params =
      first: urls[0]
      second: urls[1]
      third: urls[2]
    $.ajax
      method: "POST"
      dataType: 'json'
      url: "/posts"
      data: params
      success: (response) ->
        $('.save_page').hide()
        $('.message').text("Top stories updated.")
        setTimeout ->
          $('.message').text("")
        , 5000
      error: ->
        $('.message').text("Something went wrong updating your top stories")

