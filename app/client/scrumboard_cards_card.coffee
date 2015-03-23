Template.scrumboard_cards_card.helpers
	editMode: ->
		Session.equals "editCard", Template.currentData()._id	
	states: -> 
		_.reject Cards.States, (state) => state.value is @state

Template.scrumboard_cards_card.events
	'click .btn-set-state': (event) ->
		newState = $(event.currentTarget).data "state"
		Cards.update Template.currentData()._id, $set: state: newState
	'click .btn-delete': ->
		Cards.remove Template.currentData()._id
	'click .btn-edit': ->
		Session.set "editCard", Template.currentData()._id
	"dragstart .card": (event) ->
		event.originalEvent.dataTransfer.setData "cardId", Template.currentData()._id	
Template.scrumboard_cards_card_edit.events
	'click .btn-cancel': -> Session.set "editCard", null

# clear current edited card when a form is submitted
AutoForm.addHooks null, onSuccess: -> Session.set "editCard", null