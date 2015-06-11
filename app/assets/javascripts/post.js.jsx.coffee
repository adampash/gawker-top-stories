@Post = React.createClass
  getInitialState: ->
    editing: false
  handleClick: ->
    @setState
      editing: true
  handleCancel: (e) ->
    console.log 'handle cancel'
    @setState
      editing: false
    e.stopPropagation()

  render: ->
    postClasses = ['post']
    post = @props.post
    headline = post?.headline or ''
    img = post?.leftOfHeadline.src or ''
    permalink = post?.permalink or ''
    unless post?
      postClasses.push 'empty'
    if @state.editing
      postClasses.push 'editing'
    `<div className={postClasses.join(' ')}
      onClick={this.handleClick}
    >
        <div className="overlay">
          <i className="fa fa-plus-circle"></i>
          <i className="fa fa-pencil-square-o"></i>
          <form action="#"
            className={this.state.editing ? 'url_box' : 'url_box hide'}
          >
            <input placeholder="Paste a link to a post" type="text" className="url" value={permalink} />
            <div className="buttons">
              <button className="submit" type="submit" value="submit">OK</button>
              <a href="#" className="cancel" onClick={this.handleCancel}>Cancel</a>
            </div>
          </form>
        </div>
        <div className="content">
          <img src={img} />
          <h3>{headline}</h3>
        </div>
      </div>`
