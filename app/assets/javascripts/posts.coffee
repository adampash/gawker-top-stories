# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.post').on 'click', ->
    $(@).addClass 'editing'
    $(@).find('.url_box').show().find('.url').select()

  $('.url_box').on 'submit', ->
    console.log 'submitted'
    $(@).parents('.editing').removeClass 'editing'
    $(@).hide()
    false

  $('.url_box .cancel').on 'click', ->
    $(@).parents('.editing').removeClass 'editing'
    $(@).parents('.url_box').hide()
    false
