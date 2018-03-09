<%-- 
    Document   : manter_func
    Created on : 27/04/2017, 14:45:07
    Author     : Ramon Cordeiro
--%>

<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page import="util.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FRPTRANS - QUALIDADE EM TRANSPORTE</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="http://localhost:8282/frptransportes/css/style.css"/>
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
        <div class="panel panel-default">
            <div class="panel-heading main-color-bg">
                <h3 class="panel-title">Informações Administrativas</h3>
            </div>
        </div>
    <body>

        <%

            List<Usuario> mostrar = (List<Usuario>) request.getAttribute("retornaTodosUsuarios");

        %>
       
        <h1>Manter Funcionários </h1>
        <div class="panel-body">
            <div class="col-md-6">
                <div class="well dash-box">
                    <h2><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 203</h2>
                    <h4><a href="<%=Conf.getCaminhoContexto()%>/admin/cadastro_usuario.jsp">Cadastro Usuario</a></h4>
                </div>
            </div>
            <div class="col-md-6">
                <div class="well dash-box">
                    <h2><span class="glyphicon glyphicon-user" aria-hidden="true"></span> </h2>
                     <input type="submit"  class="btn btn-link" value="ListarUsuarios" name="acao" >
                </div>
            </div>
        </div>

        <form action="<%=Conf.getCaminhoContexto()%>ControleUsuario" method="POST">


           

        </form>


        <%
            if (mostrar != null) {%>
            <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover">
             <thead>
            <th>Nome</th>
            <th>Login</th>
            <th>Senha</th>
            <th>CNH</th>
            <th>Ações Relacionadas</th>

        </thead>

        <%
            for (Usuario u : mostrar) {
        %>





        
            <td><%=u.getNome()%></td>
            <td><%=u.getLogin()%></td>
            <td><%=u.getSenha()%></td>
            <td><%=u.getCnh()%></td>
            <td><br><a href="<%=Conf.getCaminhoContexto()%>ControleUsuario?acao=buscarUsuarioEdicao&idUsuario=<%=u.getId()%>"</a>Alterar <a href="<%=Conf.getCaminhoContexto()%>ControleUsuario?acao=usuarioExcluido&idUsuario=<%=u.getId()%>"</a>Excluir </br></td>






        </tr>



        <%}%>
    </table>

   
    <%}%>

   
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
