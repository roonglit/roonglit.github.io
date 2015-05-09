$(window).load () ->
  if ($(window).width() < 240) 
    $("#loader").hide()
    $(".mask").hide()
    $(".preload-logo").hide()
  else 
    $("#loader").delay(1000).fadeOut()
    $(".mask").delay(1000).fadeOut("slow")
    $(".preload-logo").delay(1000).fadeOut("slow")

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
