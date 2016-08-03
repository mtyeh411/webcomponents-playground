do (window, document) ->
  elementName = 'hello-name-list' # must have hyphenated prefix

  HelloNameListProto = Object.create HTMLElement.prototype
  HelloNameListProto.createdCallback = ->
    shadowRoot = @.createShadowRoot()
    clone = document.createDocumentFragment()

    names = [
     {first_name: 'Matt', last_name: 'Yeh'},
     {first_name: 'John', last_name: 'Doe'}
    ]
    names.forEach (name) ->
      component = document.createElement('hello-name')
      component.setAttribute 'name', JSON.stringify(name)
      clone.appendChild component

    shadowRoot.appendChild clone

  document.registerElement elementName,
    prototype: HelloNameListProto
