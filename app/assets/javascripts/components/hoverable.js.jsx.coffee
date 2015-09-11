@Hoverable = React.createClass
  displayName: 'Hoverable'
  timeout: null
  decode: (text) ->
    $('<textarea />').html(text).text()
  handleHover: ->
    @timeout = setTimeout =>
      @props.hoverCallback(@props.id, @props.index)
    , 100
  killHover: ->
    clearTimeout @timeout
  render: ->
    tag = @props.story?.tags?[0]?.desc
    `<div onMouseOver={this.handleHover} onMouseOut={this.killHover} className="hoverableLink">
      <a href={this.props.url} target="_blank">
        <div className={this.props.active ? 'active headline' : 'headline'}>
        <img src={this.props.img.src} />
          <div className="tag site_color">
            {tag}
          </div>
          <h4
            dangerouslySetInnerHTML={{
              __html: this.props.headline
            }}
          >
          </h4>
        </div>
      </a>
      <hr />
    </div>`
