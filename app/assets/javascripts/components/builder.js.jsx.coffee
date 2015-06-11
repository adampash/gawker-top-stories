@Builder = React.createClass
  render: ->
    posts = [0,1,2].map (index) =>
      post = @props.posts[index]
      `<Post post={post} />`
    return `<div className="posts">
        <h4>Click to change stories. Drag and drop to reorder.</h4>
        {posts}
        <br clear="all" />
        <button className="save_page">Save your new top stories</button>
        <div className="message"></div>
      </div>
    `
