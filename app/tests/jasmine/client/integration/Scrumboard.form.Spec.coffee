describe "Scrumboard", ->
	describe "form", ->
		beforeEach ->
			Cards.find().forEach (card) ->
				Cards.remove card._id

		describe "form-create-card", ->
			it "has a form to create a new Card", ->
				$form = $ "#form-create-card"
				expect($form.length).toBe 1

			it "has a input field for title", ->
				$form = $ "#form-create-card"
				$input = $form.find("[name='title']")
				expect $input.length 
				.toBe 1
				expect $input.prop("tagName").toLowerCase()
				.toBe "input"
				expect $input.prop "type"
				.toBe "text"
				 
			it "has a textarea for description", ->
				$form = $ "#form-create-card"
				$input = $form.find("[name='description']")
				expect $input.length 
				.toBe 1
				expect $input.prop("tagName").toLowerCase()
				.toBe "textarea"

			describe "estimate", ->
				it "has a select for estimate", ->
					$form = $ "#form-create-card"
					$select = $form.find("[name='estimate']")
					expect $select.length 
					.toBe 1

				it "has options 1,2,3,5,8", ->
					options = [1,2,3,5,8]
					$form = $ "#form-create-card"
					$select = $form.find("[name='estimate']")
					
					for option in options
						expect($select.find("option[value='#{option}']").length).toBe 1

			it "has a input field for the responsible person", ->
				$form = $ "#form-create-card"
				$input = $form.find("[name='responsible']")
				expect $input.length 
				.toBe 1
				expect $input.prop("tagName").toLowerCase()
				.toBe "input"
				expect $input.prop "type"
				.toBe "text"
				
			describe "submit", ->
				$form = null
				beforeEach ->
					Cards.find().forEach (card) ->
						Cards.remove card._id
					$form = $ "#form-create-card"
					$form[0].reset()
					AutoForm.resetForm "#form-create-card"
					$form.find("[name='state']").val "todo"
					Tracker.flush()
				it "shows error, if title is not given", ->
					
					$form.find("[name='description']").val Cards.SAMPLE.description
					$form.find("[name='estimate']").val Cards.SAMPLE.estimate
					$form.find("[name='responsible']").val Cards.SAMPLE.responsible
					$form.submit()
					Tracker.flush()
					expect $form.find(".has-error").length
					.not.toBe 0
					expect $(".scrumboard .card").length
					.toBe 0

				it "adds a new card to 'todo' if submitted", ->
					$form = $ "#form-create-card"
					
					Tracker.flush()
					$form.find("[name='title']").val Cards.SAMPLE.title
					$form.find("[name='description']").val Cards.SAMPLE.description
					$form.find("[name='estimate']").val Cards.SAMPLE.estimate
					$form.find("[name='responsible']").val Cards.SAMPLE.responsible
					$form.submit()
					Tracker.flush()

					share.TestHelpers.checkColumnForSampleCard $ ".scrumboard .column-todo ul.cards"
				it "only needs the title", ->
					$form.find("[name='title']").val Cards.SAMPLE.title
					$form.submit()
					Tracker.flush()
					expect $form.find(".has-error").length
					.toBe 0
					$cards = $ ".scrumboard .column-todo ul.cards"
					$card = $cards.find("li").eq(0)
					expect $card.find(".title").text()
					.toBe Cards.SAMPLE.title





			
			


		
