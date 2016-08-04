do (window, document) ->
  elementName = 'my-movies'
  componentDocument = (document._currentScript || document.currentScript).ownerDocument
  template = componentDocument.querySelector('template#movies').content

  MoviesProto = Object.create(HTMLElement.prototype)
  MoviesProto.createdCallback = ->
    base_url = 'http://netflixroulette.net/api/api.php'

    shadowRoot = @.createShadowRoot()
    clone = document.importNode template, true
    shadowRoot.appendChild clone

    if @.hasAttribute('actor')
      query = @.getAttribute('actor')
      url = "#{base_url}?actor=#{query}"
      xhr = new XMLHttpRequest()

      xhr.onload = ->
        row = shadowRoot.querySelector '.row'
        movies = JSON.parse(xhr.responseText)
        if(movies instanceof Array)
          movies.forEach (movie) ->
            component = document.createElement 'my-movie'
            component.setAttribute 'movie', JSON.stringify(movie)
            component.className = 'col-md-4 col-sm-6'
            row.appendChild component

      xhr.onerror = ->
        console.log "Error requesting for #{query}"

      xhr.open 'GET', url, true
      xhr.send()

  document.registerElement elementName,
    prototype: MoviesProto
