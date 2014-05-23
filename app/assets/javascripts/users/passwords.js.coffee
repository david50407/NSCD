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
			},
			password: {
				identifier: 'user[password]',
				rules: [
					{
						type  : 'length[8]',
						prompt: ''
					}
				]
			},
			password_confirmation: {
				identifier: 'user[password_confirmation]',
				rules: [
					{
						type  : 'length[8]',
						prompt: ''
					},
					{
						type  : 'match[user[password]]',
						prompt: ''
					}
				]
			}
		}
