do (window, document) ->
  elementName = 'hello-name' # must have hyphenated prefix
  componentDocument = (document._currentScript || document.currentScript).ownerDocument
  template = componentDocument.querySelector('template').content

  HelloNameProto = Object.create HTMLElement.prototype
  HelloNameProto.name = 'Friend'

  HelloNameProto.attachedCallback = ->
    shadowRoot = @.createShadowRoot()
    clone = document.importNode template, true
    shadowRoot.appendChild clone

    if @.hasAttribute 'name'
      obj = JSON.parse @.getAttribute('name')
      @.name = "#{obj.first_name} #{obj.last_name}"

    shadowRoot.querySelector('.name').textContent = @.name

    WebComponents.ShadowCSS?.shimStyling shadowRoot, elementName

  document.registerElement elementName,
    prototype: HelloNameProto
