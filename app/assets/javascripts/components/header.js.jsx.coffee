@Header = React.createClass
  displayName: 'Header'
  render: ->
    `<div className="header">
      <h4>
        <div
          dangerouslySetInnerHTML={{__html: this.props.text}}
        />
      </h4>
    </div>`
