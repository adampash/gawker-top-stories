@Post = React.createClass
  getInitialState: ->
    editing: false
    post: @props.post
  handleClick: (e) ->
    @setState
      editing: true
    console.log 'focus'
    setTimeout =>
      React.findDOMNode(@refs.url_box).select()
    , 100

  handleCancel: (e) ->
    console.log 'handle cancel'
    @setState
      editing: false
    e.stopPropagation()
    e.preventDefault()

  fetchPost: ->
    console.log 'fetch post'
    url = React.findDOMNode(@refs.url_box).value
    @setState
      editing: false
    # post_container = $(@).parents('.post')
    $.ajax
      method: "GET"
      dataType: 'json'
      url: "/posts"
      data: url: url
      success: (post) =>
        oldPost = @state.post
        @setState
          post: post
        @props.handleChange(post, oldPost)
      error: ->
        alert "Something went wrong fetching that post"

  render: ->
    postClasses = ['post']
    post = @state.post
    headline = post?.headline or ''
    img = post?.leftOfHeadline?.src or ''
    permalink = post?.permalink or ''
    unless post?
      postClasses.push 'empty'
    if @state.editing
      postClasses.push 'editing'
    `<div className={postClasses.join(' ')}
      onClick={this.handleClick}
      data-position={this.props.position}
    >
        <div className="overlay">
          <i className="fa fa-plus-circle"></i>
          <i className="fa fa-pencil-square-o"></i>
          <form action="#" onSubmit={this.fetchPost}
            className={this.state.editing ? 'url_box' : 'url_box hide'}
          >
            <input placeholder="Paste a link to a post" type="text" className="url" defaultValue={permalink} ref="url_box" />
            <div className="buttons">
              <button className="submit" type="submit" value="submit">OK</button>
              <a href="#" className="cancel" onClick={this.handleCancel}>Cancel</a>
            </div>
          </form>
        </div>
        <div className="content">
          <img src={img} />
          <h3
            dangerouslySetInnerHTML={{__html: headline}}
          />
        </div>
      </div>`
