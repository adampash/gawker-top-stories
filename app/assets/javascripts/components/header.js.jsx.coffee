@Header = React.createClass
  displayName: 'Header'
  render: ->
    `<div className="header">
      <h4>
        <a href={this.props.url} target="_blank"
          dangerouslySetInnerHTML={{__html: this.props.text}}
        >
        </a>
      </h4>
    </div>`
