<%-- 
    Document   : cadastro_usuario
    Created on : 23/03/2017, 16:08:31
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>FRPTRANS- QUALIDADE EM TRANSPORTE</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">FRPTRANS</a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="index.html">FRPTRANS</a></li>
                        <li><a href="pages.html">Cadastre seu Frete</a></li>
                        <li><a href="posts.html">Consulte Seu Cadastro</a></li>
                        <li><a href="users.html">Pedidos</a></li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">                    
                        <li><a href="<%=Conf.getCaminhoContexto()%>ControleAcessoCliente?acao=Sair">Logout</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </nav>
		<header id="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-10">	  
                        <h1><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> FRPTRANS</h1>

                    </div>
                </div>
            </div>
        </header>
    <body>
        <br>
        <br>
        <br>
        <br>
        <h2>Cadastro de novo usuário </h2>
        
        <%
            String msg = (String) request.getAttribute("msg");
            if(msg != null){
               
            
        
        
        %>
        <font color="blue"><%=msg %></font>
        <% } %>
        
        <form action="<%=Conf.getCaminhoContexto()%>ControleUsuario" method="POST">
             <div id="main" class="container-fluid">
 
  <!-- area de campos do form -->
  <div class="row">
 <div class="form-group col-md-4">
   <label for="campo1">Login </label>
   <input type="text" class="form-control" name="txtLogin">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo2">Senha</label>
   <input type="password" class="form-control" name="txtSenha">
 </div>
<div class="row">
 <div class="form-group col-md-4">
   <label for="campo4">Nome</label>
   <input type="text" class="form-control" name="txtNome">
 </div>
</div>
  </div>
   <div class="row">
  <div class="form-group col-md-4">
    <label for="campo10">Perfil</label>
    <select class="form-control" name="optPerfil">
      <option>ADMINISTRADOR</option>
      <option>FUNC_LOGISTICA</option>
      
    </select>
  </div>
 </div>
             </div>
        </div>
            
                 
                 <input type="submit" value="Cadastrar" name="acao" >
            
                 
         </form>
        <br>
        <button>  <a href="<%=Conf.getCaminhoContexto()%>admin/manter_func.jsp">Voltar</a> </button>
        
        <nav class="navbar navbar-inverse navbar-fixed-top">
         <div id="main" class="container-fluid">
          <div class="navbar-header">
 
   <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
   </button>
   <a class="navbar-brand" href="#">FRPTRANS</a>
  </div>
  <div id="navbar" class="navbar-collapse collapse">
   <ul class="nav navbar-nav navbar-right">
    <li><a href="#">Início</a></li>
    <li><a href="#">Opções</a></li>
    <li><a href="<%=Conf.getCaminhoContexto()%>/admin/principal_admin.jsp">Minha Conta</a></li>
    <li><a href="<%=Conf.getCaminhoContexto()%>ControleAcessoCliente?acao=Sair">Sair</a></li>
	


   </ul>
  </div>
 </div>
</nav>
  
<button><a href="<%=Conf.getCaminhoContexto()%>admin/principal_admin.jsp">Voltar</a></button>
   <footer id="footer">
      <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

  <script>
     CKEDITOR.replace( 'editor1' );
 </script>
  <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->
  <script src="js/jquery.js"></script>
  <script src="js/bootstrap.min.js"></script>
        
    </body>
</html>
