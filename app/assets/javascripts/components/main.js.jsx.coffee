@Main = React.createClass
  displayName: 'Main'
  getInitialState: ->
    activeStoryId: @props.stories[0]?.id
    activeStory: 0
    hovering: false

  cycle: ->
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
    setInterval @cycle, 7000

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
        key={story.id}
        id={story.id}
        url={story.permalink}
        img={story.img}
        active={_this.state.activeStoryId === story.id}
        index={index} />`
    return `<div className="container" onMouseOver={this.handleMouseOver} onMouseOut={this.handleMouseOut} >
            <Header text="Kotaku Covers E3" url="http://kotaku.com/tag/e3" />
            <Marquee
              story={this.props.stories[this.state.activeStory]}
              img={this.getImage(this.state.activeStory)}
            />
            <div className="links">
              {links}
            </div>
          </div>`
    # </div>`)
