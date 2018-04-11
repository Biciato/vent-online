App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # redirect user to the home
    if data.content == "qwertyuiop"
      Turbolinks.visit("https://vent-online.herokuapp.com") if window.location.href == "https://vent-online.herokuapp.com/chat"

    # here is where the core of the chat works. If we receive the user's email through out the ChatChannel
    # we add it to the chat message div. In the "if" i'm checking if the user is admin. If it isn't we
    # assure that it's the user that is not the admin
    else if data.username == 'leandrobiciato58@gmail.com'
      $('#messages').append '<div class="row">' +
                              '<div class="col-md-6">' +
                                '<div class="message-admin">' +
                                  '<h5 class="text-primary" id="message-head-admin">' + data.username + ':' + '</h5>' +
                                  '<p id="message-parag">' + data.content +  '</p>' +
                                  '<label style="display: none">' + data.id + '</label>' +
                                '</div>' +
                              '</div>' +
                            '</div>'
    else
      $('#messages').append '<div class="row">' +
                              '<div class="col-md-6">' +
                              '</div>' +
                              '<div class="col-md-6">' +
                                '<div class="message-user">' +
                                  '<h5 class="text-warning" id="message-head-user">' + data.username + ':' + '</h5>' +
                                  '<p id="message-parag">' + data.content +  '</p>' +
                                  '<label style="display: none">' + data.id + '</label>' +
                                '</div>' +
                              '</div>' +
                            '</div>'
    # check if the auto-scroll check button is clicked. If it's, calls the scroll_bottom function
    if ($('#auto-scroll').is(':checked'))
      scroll_bottom()


  # perform method speak on the server
  speak: (content, user_id) ->
      @perform 'speak', content: content, user_id: user_id

  # perform method block_user on the server
  block_user: (user_id) ->
    @perform 'block_user', user_id: user_id

  # perform method update_online on the server
  update_online: (user_id) ->
    @perform 'update_online', user_id: user_id

$(document).on 'turbolinks:load', ->
  submit_message_key()
  submit_message_click()
  direct_user()
  update_online()

# takes the text typed by the user and send to the channel when the return key is pressed
submit_message_key = () ->
  $('[data-behavior~=room_speaker]').on 'keydown', (event) ->
    if event.keyCode is 13
      id = $('#message_user_id').attr('value')
      App.chat.speak event.target.value, id
      event.target.value = ""
      event.preventDefault()

# takes the text typed by the user and send to the channel on mouse click
submit_message_click = () ->
  $('#chat-button').click (event) ->
    id = $('#message_user_id').attr('value')
    value = $('[data-behavior~=room_speaker]').val()
    App.chat.speak value, id
    $('[data-behavior~=room_speaker]').val("")
    event.preventDefault()

# called when auto-scroll check button is clicked
scroll_bottom = () ->
  $('#messages').scrollTop($('#messages')[0].scrollHeight)

# called when the direct-user button is clicked and calls block_user function
direct_user = () ->
  $('#direct-user').click (event) ->
    id = $('.message-user').find('label').first().text()
    App.chat.block_user id
    event.preventDefault()

# called when the update-online button is clicked and calls update_online function    
update_online = () ->
  $('#update-online').click (event) ->
    id = $('.message-user').find('label').first().text()
    App.chat.update_online id
    event.preventDefault()
