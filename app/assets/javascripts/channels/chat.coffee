App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
   
  disconnected: ->
    # Called when the subscription has been terminated by the server
   
  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data.content == "qwertyuiop"
      Turbolinks.visit("https://vent-online.herokuapp.com") if window.location.href == "https://vent-online.herokuapp.com/chat"
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
    if ($('#auto-scroll').is(':checked'))
      scroll_bottom()    
    
    
                            
  speak: (content, user_id) ->
      @perform 'speak', content: content, user_id: user_id
      
  block_user: (user_id) ->
    @perform 'block_user', user_id: user_id
    
  update_online: (user_id) ->
    @perform 'update_online', user_id: user_id
    
$(document).on 'turbolinks:load', ->
  submit_message_key()
  submit_message_click()
  direct_user()
  update_online()

submit_message_key = () ->
  $('[data-behavior~=room_speaker]').on 'keydown', (event) ->
    if event.keyCode is 13
      id = $('#message_user_id').attr('value')
      App.chat.speak event.target.value, id
      event.target.value = ""
      event.preventDefault() 
      
submit_message_click = () ->      
  $('#chat-button').click (event) ->
    id = $('#message_user_id').attr('value')
    value = $('[data-behavior~=room_speaker]').val()
    App.chat.speak value, id
    $('[data-behavior~=room_speaker]').val("")
    event.preventDefault()

scroll_bottom = () ->
  $('#messages').scrollTop($('#messages')[0].scrollHeight)
  
direct_user = () ->
  $('#direct-user').click (event) ->
    id = $('.message-user').find('label').first().text()
    App.chat.block_user id
    event.preventDefault()
    
update_online = () ->
  $('#update-online').click (event) ->
    id = $('.message-user').find('label').first().text()
    App.chat.update_online id
    event.preventDefault()
    

  