@Marquee = React.createClass
  displayName: 'Marquee'

  openLink: ->
    window.open @props.story.permalink

  decode: (text) ->
    $('<textarea />').html(text).text()

  deck: ->
    if @props.story.deck?
      @props.story.deck
    else
      ''

  render: ->
    return `<div />` unless @props.story?
    `<div className="marquee" onClick={this.openLink}>
      <div className="box">
        <img src={this.props.img} />
      </div>
      <div className="box">
        <div className="text">
          <h4 className="tag">{this.props.story.tags[0].desc}</h4>
          <h2>
            <a href={this.props.story.permalink} target="_blank"
              dangerouslySetInnerHTML={{
                __html: this.props.story.headline
              }}
            >
            </a>
          </h2>
          <div className={this.deck() === '' ? 'deck hide' : 'deck'}>
            <hr />
            {this.props.story.deck}
          </div>
        </div>
      </div>
    </div>`
