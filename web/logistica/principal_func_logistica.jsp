<%-- 
    Document   : principal_func_logistica
    Created on : 08/04/2017, 14:27:50
    Author     : Ramon Cordeiro
--%>

<%@page import="model.Viagem"%>
<%@page import="model.Agenda_Veiculo"%>
<%@page import="model.Ordem_Servico"%>
<%@page import="java.util.List"%>
<%@page import="util.Conf"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Principal_Func_Logistica</title>
       <link href="../css/style.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
       <link rel="stylesheet" type="text/css" href="http://localhost:8282/frptransportes/css/style.css"/>
        <link href="../css/tables.css" rel="stylesheet">
        <script src="../js/jquery.min.js"></script>
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
        </header>
        <div class="panel panel-default">
            <div class="panel-heading main-color-bg">
                <h3 class="panel-title">Informações Administrativas</h3>
            </div>
        </div>
    <body    <%List<Agenda_Veiculo> agenda_veiculo = (List<Agenda_Veiculo>) session.getAttribute("retornaListaAgenda");%>
        <%String erro = (String) session.getAttribute("erroDatasIguais"); %>
        <%if (agenda_veiculo == null) {%>

        
        onload="carregaAgenda()"

        <%}%>
        <%if (erro != null)  {%>
    
        onload="ErroDatasIguais()"
        
        <%request.removeAttribute("erroDatasIguais"); %>

        <%}%>
        

        >
        <%Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario != null) {
        %>
     
        <h3>Bem Vindo, <%= usuario.getLogin()%>  </h3> 
        
         <h3> ESCOLHA UMA OPÇÃO</h2>
        <div class="panel-body">
            <div class="col-md-12">
                <div class="well dash-box">
                    <h2><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></h2>
                    <h4><a href="manter_veiculo.jsp">Manter Veículos</a></h4>
                </div>
            </div>
            
        </div>

        <%if (agenda_veiculo != null) {%>
        
        <h2>Viagens:</h2>
        <div class="table-responsive">
            <table  id="example" class="table table-striped table-bordered table-hover">
                <thead>
                    <tr class="headings">
                        <th> </th>
                        <th>Nº Viagem</th>
                        <th>Data do Frete</th>
                        <th>Modelo Veiculo</th>
                        <th>Placa veiculo</th>
                        <th>Status Agenda</th>
                        <th>Ações Relacionadas</th>
                        <th></th>
                    </tr>
                </thead>
                <form action="<%=Conf.getCaminhoContexto()%>ControleOrdemServico" method="POST">
                    
                        
                <div class="form-group col-md-4">
                <select name="statusCombo" class="form-control">
                        
                    <option>PENDENTE</option>
                    <option>ANDAMENTO</option>
                    <option>ENCERRADO</option>
                        
                </select>
                </div>  
                    <input type="submit" value="Consultar" name="acao" >
                    
                    <br>
                    <br>
                    <br>
                
                    <input type="submit" value="Combinar" name="acao" >
                    <input type="submit" value="VerMais" name="acao" >  
                    <%
                        for (int i = 0; i< agenda_veiculo.size(); i++) {
                             Agenda_Veiculo agV = new Agenda_Veiculo();
                             agV = agenda_veiculo.get(i);
                    %>
                   
                    <tr class="odd pointer">
                        
                        <td class=" "><input type="checkbox" onclick=" completaCheck<%=agV.getId()%>()" id="checkbox<%=agV.getId()%><%=i%>" name="viagens" value="<%=agV.getId()%>"> </td> 
                        <td class=" "><%=agV.getId()%></td>
                        <td class=" "><%=agV.getData_agenda()%></td>
                        <td class=" "><%=agV.getModelo_veic()%></td>
                        <td class=" "><%=agV.getStatus()%></td> 
                        <td class=" "><%=agV.getPlaca_veic()%></td>
                        <td><br><a href="<%=Conf.getCaminhoContexto()%>ControleOrdemServico?acao=ConfirmaViagem&idAgenda=<%=agV.getId()%>">ConfirmaViagem</a><br><a href="<%=Conf.getCaminhoContexto()%>ControleOrdemServico?acao=EncerraViagem&idAgenda=<%=agV.getId()%>">EncerraViagem</a>
                        <td class=" "><input type="checkbox" hidden id="checkbox<%=agV.getId() %><%=i+1%>" name="viagens2" value="<%=agV.getId()%>" </td> 
                    </tr>

                    <script>
                         function completaCheck<%=agV.getId()%>(){
                             if(document.getElementById("checkbox<%=agV.getId()%><%=i%>").checked){
                        document.getElementById("checkbox<%=agV.getId()%><%=i + 1%>").checked = true;
                }else{
                    document.getElementById("checkbox<%=agV.getId()%><%=i + 1%>").checked = false;

                }
            }
                    </script>

          

            <% } %>
            </form>
</table>
  <% session.removeAttribute("retornaListaAgenda");%>
            <% } %>
            <%}%>

            
            <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->
            <script>function carregaAgenda() {

                    location.href = "<%=Conf.getCaminhoContexto()%>ControleAgenda?acao=ExibeAgendaFunc";

                }
                
            
            </script>
            <script>
        function ErroDatasIguais(){
                            alert('Não foi possivel combinar as viagens ! Datas iguais, favor verificar !');
                        }
            </script>
            <footer id="footer">
        <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

    

    <script>
        CKEDITOR.replace('editor1');
    </script>
            <script src="../js/jquery.js"></script>
            <script src="../js/bootstrap.min.js"></script>
            <script src="../js/jquery.dataTables.js"></script>  
            <script src="../js/dataTables.tableTools.js"></script>
<!--           <script>
    var asInitVals = new Array();
    $(document).ready(function () {
        var oTable = $('#example').dataTable({
            "oLanguage": {
                "sSearch": "Procurar por:"
            },
            "aoColumnDefs": [
                {
                    'bSortable': false,
                    'aTargets': [0]
                } //disables sorting for column one
            ],
            'iDisplayLength': 10,
            "sPaginationType": "full_numbers"
        });
        $("tfoot input").keyup(function () {
            /* Filter on the column based on the index of this element's parent <th> */
            oTable.fnFilter(this.value, $("tfoot th").index($(this).parent()));
        });
        $("tfoot input").each(function (i) {
            asInitVals[i] = this.value;
        });
        $("tfoot input").focus(function () {
            if (this.className == "search_init") {
                this.className = "";
                this.value = "";
            }
        });
        $("tfoot input").blur(function (i) {
            if (this.value == "") {
                this.className = "search_init";
                this.value = asInitVals[$("tfoot input").index(this)];
            }
        });
    });
</script>-->
    </body>
</html>
