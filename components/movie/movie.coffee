do (window, document) ->
  elementName = 'my-movie'
  componentDocument = (document._currentScript || document.currentScript).ownerDocument
  template = componentDocument.querySelector('template#movie').content

  MovieProto = Object.create HTMLElement.prototype
  MovieProto.attachedCallback = ->
    shadowRoot = @.createShadowRoot()
    clone = document.importNode template, true
    shadowRoot.appendChild clone

    if @.hasAttribute('movie')
      movie = JSON.parse @.getAttribute('movie')
      for key, value of movie
        el = shadowRoot.querySelector ".#{key}"
        if el?.nodeName == 'IMG'
          el?.setAttribute 'src', value
        else
          el?.textContent = value

    WebComponents.ShadowCSS?.shimStyling shadowRoot, elementName

  document.registerElement elementName,
    prototype: MovieProto
