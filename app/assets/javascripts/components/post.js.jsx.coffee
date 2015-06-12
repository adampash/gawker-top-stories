@Post = React.createClass
  getInitialState: ->
    editing: false
    deckEdit: false
    post: @props.post
  handleClick: (e) ->
    @setState
      editing: true
    setTimeout =>
      React.findDOMNode(@refs.url_box).select()
    , 100

  handleChange: (e) ->
    e.stopPropagation()
    @setState
      deckEdit: true

  saveDeck: (e) ->
    e.stopPropagation()
    e.preventDefault()
    deck = React.findDOMNode(@refs.deck).value
    console.log @props.post.headline
    $.ajax
      url: '/update_deck'
      data:
        id: @props.post.id
        deck: deck
      dataType: 'json'
      method: "POST"
      success: (post) =>
        @props.handleUpdate()
        @setState
          deckEdit: false
      error: =>


  handleCancel: (e) ->
    @setState
      editing: false
    e.stopPropagation()
    e.preventDefault()

  fetchPost: (e) ->
    url = React.findDOMNode(@refs.url_box).value
    e.preventDefault()
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
    deck = post?.deck or ''
    img = post?.image?.src or ''
    permalink = post?.permalink or ''
    postClasses.push 'empty' unless post?
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
          <div className="deck">
            <textarea ref="deck"
              onClick={this.handleChange}
              onChange={this.handleChange}
              defaultValue={deck} />
            <button disabled={this.state.deckEdit ? '' : 'disabled'}
              onClick={this.saveDeck}
            >
              Save<br />Deck
            </button>
          </div>
        </div>
        <div className="content">
          <img src={img} />
          <h3
            dangerouslySetInnerHTML={{__html: headline}}
          />
        </div>
      </div>`
