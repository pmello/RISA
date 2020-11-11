
user function A010TOK()
	local lValido := .T.

	// Verifica se o produto está bloqueado
	if (M->B1_MSBLQL != "1" .and. empty(M->B1_GRTRIB))
		lValido := .F.
		msgAlert("O campo 'GRUPO TRIBUTÁRIO' deve ser preenchido.")
	endif
Return (lValido)