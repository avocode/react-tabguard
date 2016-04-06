TabGuard = React.createFactory(require '../src/')

{div, h1, p, input, button, select, option, textarea, a, fieldset} = React.DOM

module.exports = React.createClass
  displayName: 'App'

  render: ->
    div null,

      h1 null, 'First form'

      TabGuard null,
        div null,

          fieldset null,
            input
              type: 'text'
              placeholder: 'Your name'

          fieldset null,
            input
              type: 'number'
              placeholder: 'Age'

          fieldset null,
            textarea
              placeholder: 'Additional info'

          fieldset null,
            button null,
              'Send'

      h1 null, 'Second form'

      TabGuard null,
        div null,

          fieldset null,
            input
              type: 'text'
              placeholder: 'Your name'

          fieldset null,
            input
              type: 'number'
              placeholder: 'Age'

          fieldset null,
            textarea
              placeholder: 'Additional info'

          fieldset null,
            button null,
              'Send'
