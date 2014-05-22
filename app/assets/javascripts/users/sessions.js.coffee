$(document).on 'page:change', ->
	$('.ui.form[action="/users/sign_in"]').form {
			username: {
				identifier: 'user[username]',
				rules: [
					{
						type  : 'empty',
						prompt: ''
					}
				]
			},
			password: {
				identifier: 'user[password]',
				rules: [
					{
						type  : 'empty',
						prompt: ''
					},
					{
						type  : 'length[8]',
						prompt: ''
					}
				]
			}
		}
