describe '<hello-name>', ->
  beforeEach ->
    light_element = document.createElement 'strong'
    light_element.textContent = '<strong> in light DOM'
    document.body.appendChild light_element

    @component = document.createElement 'hello-name'
    @component.setAttribute 'name', JSON.stringify({first_name: 'Matt', last_name: 'Yeh'})
    document.body.appendChild @component

    @shadow = @component.shadowRoot

  it 'has shadowRoot element', ->
    setTimeout ->
      expect(@shadow).not.toBeUndefined()
      expect(@shadow).not.toBeNull()
    , 10 # wait for HTML Import polyfill

  it 'renders name', ->
    setTimeout ->
      expect(@shadow.querySelector('.name').textContent).toEqual 'Matt Yeh'
    , 10

  it 'styles name and respects Shadow DOM boundary', ->
    setTimeout ->
      shadow_style = window.getComputedStyle @shadow.querySelector('strong')
      light_style = window.getComputedStyle window.querySelector('strong')
      expect(shadow_style.color).to eq 'red'
      expect(light_style.color).not.to eq 'red'
    , 10
