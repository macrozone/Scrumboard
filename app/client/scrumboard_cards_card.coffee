Template.scrumboard_cards_card.helpers
	states: -> 
		_.reject Cards.States, (state) => state.value is @state

Template.scrumboard_cards_card.events
	'click .btn-set-state': (event) ->
		newState = $(event.currentTarget).data "state"
		Cards.update Template.currentData()._id, $set: state: newState
	'click .btn-delete': ->
		Cards.remove Template.currentData()._id
	"dragstart .card": (event) ->
		event.originalEvent.dataTransfer.setData "cardId", Template.currentData()._id