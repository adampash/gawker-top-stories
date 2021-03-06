@Builder = React.createClass
  getInitialState: ->
    changed: false
    message: ''
    order: [0,1,2]
    posts: @props.posts
    title: @props.title
  getDefaultProps: ->
    posts: [null, null, null]
  componentDidMount: ->
    $('.posts').sortable
      cursor: 'move'
      update: (e) =>
        order = $('.post', e.target).map (index, post) ->
          $(post).data('position')
        @setState
          changed: true
          order: order
      items: "> div.post"

  handleTitleChange: (e) ->
    @setState
      changed: true
      title: e.target.value

  handleChange: (newPost, oldPost) ->
    posts = @state.posts
    posts = _.compact(posts)
    for post, index in posts
      if post is oldPost
        posts[index] = newPost
        break
    unless newPost in posts
      posts.push newPost
    posts.push(null) until posts.length > 2
    console.log posts
    @setState
      changed: true
      posts: posts

  saveStories: (e) ->
    e.preventDefault()
    ids = @state.posts.map (post) -> post?.id
    order = @state.order
    params =
      first: ids[order[0]]
      second: ids[order[1]]
      third: ids[order[2]]
      site: @props.site
      title: @state.title
    $.ajax
      method: "POST"
      dataType: 'json'
      url: "/posts"
      data: params
      success: (response) =>
        @setState
          changed: false
          message: "Top stories updated"
          order: [0,1,2]
        setTimeout =>
          @setState
            message: ''
        , 5000
        posts = @state.posts
        @props.handleUpdate [
          posts[order[0]]
          posts[order[1]]
          posts[order[2]]
        ]
      error: =>
        @setState
          message: ''
    #     $('.message').text("Something went wrong updating your top stories")

  render: ->
    if @props.posts.length is 0
      all_posts = [0,1,2]
    else
      all_posts = @state.posts
    # posts = [0,1,2].map (index) =>
    posts = []
    for post, index in all_posts
      posts.push `<Post key={index}
        position={this.state.order[index]}
        post={post}
        handleChange={this.handleChange}
        handleUpdate={this.props.handleUpdate}
        />`
    return `<div className="posts">
        <div className="title">
          <label>Header:</label>
          <input
            type="text"
            defaultValue={this.props.title}
            onChange={this.handleTitleChange}
          />
        </div>
        <h4>Click to change stories. Drag and drop to reorder.</h4>
        {posts}

        <div className="clear">
          <button className={this.state.changed ? 'save_page' : 'save_page hide'}
            onClick={this.saveStories}
          >
            Save your new top stories
          </button>
          <div className="message">{this.state.message}</div>
        </div>
      </div>
    `
