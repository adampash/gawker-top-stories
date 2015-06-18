@App = React.createClass
  getInitialState: ->
    if @props.stories?
      stories = @props.stories
    else
      stories = [0,1,2]
    state =
      stories: stories
      title: @getTitle(@props.title)

  getTitle: (title) ->
    if title? and title != ""
      title = title
    else
      title = "#{@props.site} Top Stories"


  updateStories: (stories) ->
    @reload()

  reload: ->
    $.ajax
      method: "GET"
      url: '/posts/index'
      dataType: 'json'
      data:
        site: @props.site
      success: (data) =>
        @setState
          stories: []
        @setState
          stories: data.stories
          title: @getTitle(data.title)

  render: ->
    `<div>
      <Builder posts={this.state.stories}
        handleUpdate={this.updateStories}
        site={this.props.site}
        title={this.state.title}
      />
      <div className="preview">
        <div className="center">
          <h2>Preview</h2>
          <Main stories={this.state.stories} title={this.state.title} />
        </div>
      </div>
    </div>`
