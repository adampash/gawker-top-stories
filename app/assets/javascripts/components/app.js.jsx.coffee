@App = React.createClass
  getInitialState: ->
    if @props.stories?
      stories = @props.stories
    else
      stories = [0,1,2]
    return stories: stories

  updateStories: (stories) ->
    @reload()
    # @setState
    #   stories: stories

  reload: ->
    $.ajax
      method: "GET"
      url: '/posts/index'
      dataType: 'json'
      data:
        site: @props.site
      success: (stories) =>
        @setState
          stories: []
        @setState
          stories: stories

  render: ->
    `<div>
      <Builder posts={this.state.stories}
        handleUpdate={this.updateStories}
      />
      <div className="preview">
        <div className="center">
          <h2>Preview</h2>
          <Main stories={this.state.stories} />
        </div>
      </div>
    </div>`
