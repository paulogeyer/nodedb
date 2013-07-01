# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

delay = ->
  timer = 0
  (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback,ms)
    undefined

updateLatLngFields = (lat,lng) ->
  $("#node_lat").val(lat)
  $("#node_lng").val(lng)


initMap = ->
  mapOptions =
  center: new google.maps.LatLng(-27.602519,-48.518383)
  zoom: 12
  mapTypeId: google.maps.MapTypeId.ROADMAP
  window.map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions)

initNew = ->
  return if $("body").data('action') != 'new'
  geocoder = new google.maps.Geocoder();
  $("#node_address, #node_city").bindWithDelay(
    "keyup",
    ->
      address = $("#node_address").val() + ' ' +
                $("#node_city").val() + ' ' +
                "BRA"
      geocoder.geocode {'address': address}, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          latLng = results[0].geometry.location
          map.setCenter latLng
          updateLatLngFields(latLng.jb, latLng.kb)
          if window.marker
            window.marker.setPosition(latLng)
            window.map.panTo(latLng)
          else
            window.marker = new google.maps.Marker
              map: window.map,
              draggable: true,
              position: latLng
            google.maps.event.addListener window.marker, 'dragend', (evt) ->
              updateLatLngFields(evt.latLng.jb, evt.latLng.kb)
              console.log evt.latLng

      console.log $(this).val()
    , 1000
  )
  map_canvas = $('#map_canvas')
  geocodeAddr = (addr) ->
    geocoder = new google.maps.Geocoder()
    geocoder.geocode {'address': addr},
      (results, status) ->
        if status = google.maps.GeocoderStatus.OK
          window.map.setCenter(results[0].geometry.location)
        else
          alert 'failed to geocode'
  initMap()
  geocodeAddr("Florianopolis - SC, BRA")
  

initIndex = ->
  return if $("body").data('action') != 'index'
  initMap()
  window.nodes = $("tbody").data('nodes')
  window.markers = []
  window.infoWindows = []
  for node in window.nodes
    infoWindow = new google.maps.InfoWindow
      content: node.description

    marker = new google.maps.Marker
      map:window.map,
      position: new google.maps.LatLng(node.lat,node.lng)

    google.maps.event.addListener marker, 'click', ->
      infoWindow.open(window.map,marker)

    window.markers.push(marker)
    console.log node

document.addEventListener("page:load", initIndex)
document.addEventListener("page:load", initNew)

$(document).ready ->
  initIndex()
  initNew()

                                                                
