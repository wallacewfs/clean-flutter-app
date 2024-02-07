# Login Presenter

    > ## Regras

     ✅ Chamar Validation ao alterar o email
     ✅ Notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
     Notificar o emailErrorStream com null, caso o Validation não retorne erro
     Não notificar o emailErrorStream se o valor for igual ao último
     Notificar o isFormValidStream após alterar o email
     Chamar Validation ao alterar a senha
     Notificar o passwordErrorStream com o mesmo erro do Validation, caso retorne erro
     Notificar o passwordErrorStream com null, caso o Validation não retorne erro
     Não notificar o passwordErrorStream se o valor for igual ao último
     Notificar o isFormValidStream após alterar a senha
     Para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios
     Não notificar o isFormValidStream se o valor for igual ao último
     Chamar o Authentication com email e senha corretos
     Notificar o isLoadingStream como true antes de chamar o Authentication
     Notificar o isLoadingStream como false no fim do Authentication
     Notificar o mainErrorStream caso o Authentication retorne erro
     Fechar todos os Streams no dispose
     Gravar o Account no cache em caso de sucesso
     Notificar o mainErrorStream caso o SaveCurrentAccount retorne erro
     Levar o usuário pra tela de Enquetes em caso de sucesso
     Levar o usuário pra tela de Criar Conta ao clicar no link de criar conta
