describe "Scrumboard", ->
	describe "form", ->
		beforeEach ->
			Cards.find().forEach (card) ->
				Cards.remove card._id

		describe "form-create-card", ->
			it "has a form to create a new Card", ->
				$form = $ ".scrumboard form.form-create-card"
				expect($form.length).toBe 1

			it "has a input field for title", ->
				$form = $ ".scrumboard form.form-create-card"
				$input = $form.find("[name='title']")
				expect $input.length 
				.toBe 1
				expect $input.prop("tagName").toLowerCase()
				.toBe "input"
				expect $input.prop "type"
				.toBe "text"
				 
			it "has a textarea for description", ->
				$form = $ ".scrumboard form.form-create-card"
				$input = $form.find("[name='description']")
				expect $input.length 
				.toBe 1
				expect $input.prop("tagName").toLowerCase()
				.toBe "textarea"

			describe "estimate", ->
				it "has a select for estimate", ->
					$form = $ ".scrumboard form.form-create-card"
					$select = $form.find("[name='estimate']")
					expect $select.length 
					.toBe 1

				it "has options 1,2,3,5,8", ->
					options = [1,2,3,5,8]
					$form = $ ".scrumboard form.form-create-card"
					$select = $form.find("[name='estimate']")
					
					for option in options
						expect($select.find("option[value='#{option}']").length).toBe 1

			it "has a input field for the responsible person", ->
				$form = $ ".scrumboard form.form-create-card"
				$input = $form.find("[name='responsible']")
				expect $input.length 
				.toBe 1
				expect $input.prop("tagName").toLowerCase()
				.toBe "input"
				expect $input.prop "type"
				.toBe "text"

			it "adds a new card to 'todo' if submitted", ->
				$form = $ ".scrumboard form.form-create-card"
				$form.find("[name='title']").val Cards.SAMPLE.title
				$form.find("[name='description']").val Cards.SAMPLE.description
				$form.find("[name='estimate']").val Cards.SAMPLE.estimate
				$form.find("[name='responsible']").val Cards.SAMPLE.responsible
				$form.submit()
				Tracker.flush()
				share.TestHelpers.checkColumnForSampleCard $ ".scrumboard .column-todo ul.cards"
				




			
			


		
