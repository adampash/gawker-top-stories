@Marker = React.createClass
  numToWord:
    0: 'zero'
    1: 'one'
    2: 'two'
  render: ->
    `<div className="marker">
      <div className={"mark " + this.numToWord[this.props.position]} />
    </div>`
