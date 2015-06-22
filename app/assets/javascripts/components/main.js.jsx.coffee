@Main = React.createClass
  displayName: 'Main'
  getInitialState: ->
    activeStoryId: @props.stories[0]?.id
    activeStory: 0
    hovering: false

  getTitle: (title) ->
    if title? and title != ""
      title = title
    else
      title = "#{@props.site} Top Stories"

  mobileImage: ->
    img_obj = @props.stories?[0]?.image
    return unless img_obj?
    transform = "c_fill,fl_progressive,g_north,h_358,q_80,w_636"
    img_url = "http://i.kinja-img.com/gawker-media/image/upload"
    "#{img_url}/#{transform}/#{img_obj.id}.#{img_obj.format}"

  resize: ->
    height = $('.container').height()
    window.top.postMessage(
      JSON.stringify(
        kinja:
          sourceUrl: window.location.href
          resizeFrame:
            height: height
      ), '*'
    )

  preloadImage: (index=0) ->
    img = new Image()
    img.onload = =>
      return false if index is 2
      console.log 'load next'
      @preloadImage(index + 1)
    img.src = @getImage(index)

  cycle: ->
    @resize()
    unless @state.hovering
      if @state.activeStory is @props.stories.length - 1
        activeStory = 0
      else
        activeStory = @state.activeStory + 1
      @setState
        activeStory: activeStory
        activeStoryId: @props.stories[activeStory].id

  getImage: (index) ->
    return '' unless @props.stories[index]?
    img_obj = @props.stories[index].image
    img_url = "http://i.kinja-img.com/gawker-media/image/upload/t_318x318centered/"
    "#{img_url}#{img_obj.id}.#{img_obj.format}"

  componentDidMount: ->
    window.addEventListener('resize', @resize)
    setInterval @cycle, 7000
    @resize()
    @preloadImage()
    setTimeout =>
      @resize()
    , 100

  componentWillUnmount: ->
    window.removeEventListener('resize', @resize)

  hoverCallback: (storyId, storyIndex) ->
    @setState
      activeStoryId: storyId
      activeStory: storyIndex

  handleMouseOver: ->
    @setState
      hovering: true
  handleMouseOut: ->
    @setState
      hovering: false

  render: ->
    links = @props.stories.map (story, index) =>
      return `<div />` unless story?
      `<Hoverable
        hoverCallback={_this.hoverCallback}
        headline={story.headline}
        story={story}
        key={story.id}
        id={story.id}
        url={story.permalink}
        img={story.image}
        active={_this.state.activeStoryId === story.id}
        index={index} />`
    return `<div className="container" onMouseOver={this.handleMouseOver} onMouseOut={this.handleMouseOut} >
            <Header text={this.getTitle(this.props.title)} />
            <Marquee
              story={this.props.stories[this.state.activeStory]}
              img={this.getImage(this.state.activeStory)}
              mobile={this.mobileImage()}
            />
            <Marker position={this.state.activeStory} />
            <div className="links">
              {links}
            </div>
          </div>`
