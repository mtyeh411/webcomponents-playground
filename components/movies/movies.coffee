do (window, document) ->
  elementName = 'my-movies'
  base_url = 'http://netflixroulette.net/api/api.php'

  MoviesProto = Object.create(HTMLElement.prototype)
  MoviesProto.createdCallback = ->
    shadowRoot = @.createShadowRoot()
    clone = document.createDocumentFragment()

    if @.hasAttribute('actor')
      query = @.getAttribute('actor')
      url = "#{base_url}?actor=#{query}"
      xhr = new XMLHttpRequest()

      xhr.onload = ->
        movies = JSON.parse(xhr.responseText)
        if(movies instanceof Array)
          movies.forEach (movie) ->
            component = document.createElement 'my-movie'
            component.setAttribute 'movie', JSON.stringify(movie)
            clone.appendChild component
          shadowRoot.appendChild clone

      xhr.onerror = ->
        console.log "Error requesting for #{query}"

      xhr.open 'GET', url, true
      xhr.send()

  document.registerElement elementName,
    prototype: MoviesProto
