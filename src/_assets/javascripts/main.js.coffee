
###################
# Page Preloader
$(window).load () ->
  if ($(window).width() < 240) 
    $("#loader").hide()
    $(".mask").hide()
    $(".preload-logo").hide()
  else 
    $("#loader").delay(1000).fadeOut()
    $(".mask").delay(1000).fadeOut("slow")
    $(".preload-logo").delay(1000).fadeOut("slow")
# End Page preloader
###################

###################
# Viewport Adjuster
viewportHeight = $(window).height()
$('.splash-section, .autoheight').css('height',viewportHeight)
$('autoheight_half').css('height',viewportHeight/1.5)
# Element Centering
parent_height      = $('.autoheight').height()
parent_height_half = $('.autoheight_half').height()
top_margin         = (parent_height)/3.2
top_margin_half    = (parent_height_half)/2
top_margin_quart   = (parent_height)/3.8    
# center it
$('.vertical-center').css( 'padding-top' , top_margin)
$('.vertical-center-half').css('padding-top' , top_margin_half)
$('.vertical-center-quart').css('padding-top' , top_margin_quart)
$('.vertical-center-quart-mar').css('margin-top' , top_margin_quart)
# uncomment the following if ithe element to be centered is an image
$('.vertical-center-img').css( 'margin-top' , top_margin)
# End Viewport Adjuster
###################

###################
# Sticky Nav
$(window).scroll () ->
  if $('.main_navigation').offset().top > 50
    $('.main_navigation').addClass 'stuck'
  else
    $('.main_navigation').removeClass 'stuck'
# End Sticky Nav
###################

$ ->
  ###################
  # Scrolling menu
  $('.scroll-link').click () ->
    ScrollOffset = $(this).attr('data-soffset')
    $("html, body").animate
      scrollTop: $($(this).attr("href")).offset().top - ScrollOffset + "px"
    , 
      duration: 1500,
      easing: "swing"
        
    return false;
  # End Scrolling menu
  ###################
  
  ###################
  # Appearance Animation
  if !device.tablet() && !device.mobile()
    $(window).load () ->
      new WOW().init()
  # End Appearance Animation
  ###################

  ###################
  # Contact Form
  $(".error").hide()
  $(".failure").hide()
  $(".success").hide()

  isValidEmailAddress = (email) ->
    pattern = new RegExp(/^(("[\w-+\s]+")|([\w-+]+(?:\.[\w-+]+)*)|("[\w-+\s]+")([\w-+]+(?:\.[\w-+]+)*))(@((?:[\w-+]+\.)*\w[\w-+]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][\d]\.|1[\d]{2}\.|[\d]{1,2}\.))((25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\.){2}(25[0-5]|2[0-4][\d]|1[\d]{2}|[\d]{1,2})\]?$)/i)
    pattern.test(email)

  $('#messageForm input').click (evt) ->
    $('.error').fadeOut()

  $('#send-message').click (evt) ->
    evt.stopPropagation()
    evt.preventDefault()
    $(".error").hide()
    $(".failure").hide()
    $(".success").hide()
    name = $.trim($('#message-name').val())

    if name == ''
      $('#fname').fadeIn('slow')
      $('#message-name').focus()
      return false

    email = $.trim($('#message-email').val())

    if (email == '') || !isValidEmailAddress(email)
      $('#fmail').fadeIn('slow')
      $('#message-email').focus()
      return false

    number = $('#message-number').val()

    message = $('#message-content').val()

    if message == ''
      $('#fmsg').fadeIn('slow')
      $('#message-content').focus()
      return false

    Parse.initialize("Mx6Ohx8bRrikzKD0zOC8gnfaWbj7uNMcosRyYyHi", "klHtk2yR6CZUpg2Pns90NPMQpyliv6W2URbOB2qV")

    data = 
      name: name
      email: email
      number: number
      message: message

    Parse.Cloud.run('sendEmail', data, 
      success: (object) ->
        $('#success').show();
    ,
      error: (object, error) ->
        $('#failure').show();
    )
  # End Contact Form
  ###################

  ###################
  # Intro Carousel
  sync1 = $('#sync1')
  sync2 = $('#sync2')

  sync1.owlCarousel
    singleItem: true
    slideSpeed: 1000
    navigation: false
    pagination: false
    afterAction: syncPosition
    responsiveRefreshRate : 200

  sync2.owlCarousel
    items: 2
    itemsDesktop: [1199,2]
    itemsDesktopSmall: [979,2]
    itemsTablet: [768,2]
    itemsMobile: [479,2]
    pagination: false
    responsiveRefreshRate: 100
    afterInit: (el) ->
      el.find(".owl-item").eq(0).addClass("synced")

  syncPosition = (el) ->
    current = this.currentItem
    $("#sync2").find(".owl-item").removeClass("synced").eq(current).addClass("synced")
    if $("#sync2").data("owlCarousel") != undefined
      center(current);
      
  $("#sync2").on 'click', '.owl-item', (e) ->
    e.preventDefault()
    number = $(this).data("owlItem")
    sync1.trigger("owl.goTo",number)
    
  center = (number) ->
    sync2visible = sync2.data("owlCarousel").owl.visibleItems
    num = number
    found = false
    for i in sync2visible
      if num == sync2visible[i]
        found = true
        
    if found == false
      if num > sync2visible[sync2visible.length-1]
        sync2.trigger("owl.goTo", num - sync2visible.length+2)
      else
        if(num - 1 == -1)
          num = 0;
        sync2.trigger("owl.goTo", num);
      
    else if num == sync2visible[sync2visible.length-1]
      sync2.trigger("owl.goTo", sync2visible[1])
    else if num == sync2visible[0]
      sync2.trigger("owl.goTo", num-1)
    
  # End Intro Carousel
  ###################
