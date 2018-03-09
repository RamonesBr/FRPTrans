
<%-- 
    Document   : login_cliente
    Created on : 18/04/2017, 09:51:25
    Author     : Ramon Cordeiro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Area | Account Login</title>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="http://cdn.ckeditor.com/4.6.1/standard/ckeditor.js"></script>
  </head>
  <body>

    <nav class="navbar navbar-default">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">FRPTRANS </a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">

        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <header id="header">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1 class="text-center"> Acesse sua Conta  </h1>
          </div>
        </div>
      </div>
    </header>

    <section id="main">
      <div class="container">
        <div class="row">
          <div class="col-md-4 col-md-offset-4">
              <script>
              <%
           String msg = (String) request.getAttribute("msg");
           if(msg!=null){
               
           
         %>
         
             
                 alert ("<%=msg%>")
         <% } %>
         </script>
             
		   <form action="ControleAcesso" method="POST">
               <form class="login" action="index.html" class="well">
                  <div class="form-group">
                    <label>Login</label>
                    <input type="text" name="txtLogin" class="form-control" placeholder="Login">
                  </div>
                  <div class="form-group">
                    <label>Senha</label>
                    <input type="password" name="txtSenha" class="form-control" placeholder="Senha">
                  </div>
                  <input type="submit" value="Entrar" class="btn btn-default btn-block" name="acao" />
              </form>
          </div>
        </div>
      </div>
    </section>

    <footer id="footer">
      <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

  <script>
     CKEDITOR.replace( 'editor1' );
 </script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
