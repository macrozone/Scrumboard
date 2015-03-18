Router.route "scrumboard",
	path: "/"
	template: "scrumboard"
	subscriptions: -> Meteor.subscribe "cards"
	data: ->
		states: -> _.values Cards.States

Template.scrumboard_cards.helpers
	cards: ->
		Cards.find state: @state

Template.scrumboard_column.events
	'dragover .column': (event) -> event.preventDefault()
	"drop .column": (event) ->
		event.preventDefault()
		cardId = event.originalEvent.dataTransfer.getData "cardId"
		Cards.update cardId, $set: state: Template.currentData().value