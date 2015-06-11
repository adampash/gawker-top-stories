@Hoverable = React.createClass
  displayName: 'Hoverable'
  timeout: null
  handleHover: ->
    @timeout = setTimeout =>
      @props.hoverCallback(@props.id, @props.index)
    , 100
  killHover: ->
    clearTimeout @timeout
  render: ->
    `<div onMouseOver={this.handleHover} onMouseOut={this.killHover} className="hoverableLink">
      <a href={this.props.url} target="_blank">
        <div className={this.props.active ? 'active dot' : 'dot'} />
        <div className="headline">
          <h4>
            {this.props.headline}
          </h4>
        </div>
      </a>
    </div>`
