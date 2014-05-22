$(document).on 'page:change', ->
	$('.ui.form[action="/users/password"]').form {
			username: {
				identifier: 'user[username]',
				rules: [
					{
						type  : 'empty',
						prompt: ''
					}
				]
			},
			email: {
				identifier: 'user[email]',
				rules: [
					{
						type  : 'empty',
						prompt: ''
					},
					{
						type  : 'email',
						prompt: ''
					}
				]
			}
		}
