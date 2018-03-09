<%-- 
    Document   : cadastro_Frete
    Created on : 03/05/2017, 13:56:56
    Author     : Ramon Cordeiro 
--%>

<%@page import="model.Pacote"%>
<%@page import="model.Agenda_Veiculo"%>
<%@page import="util.Conf"%>
<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Frete</title>
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        
        <script type="text/javascript" >
    
    function limpa_formulário_cepOrigem() {
            //Limpa valores do formulário de cep.
            document.getElementById('ruaO').value=("");
            document.getElementById('bairroO').value=("");
            document.getElementById('cidadeO').value=("");
            
    }
    function limpa_formulário_cepDestino() {
            //Limpa valores do formulário de cep.
            document.getElementById('ruaD').value=("");
            document.getElementById('bairroD').value=("");
            document.getElementById('cidadeD').value=("");
            
    }

    function meu_callbackOrigem(conteudo) {
        if (!("erro" in conteudo)) {
            //Atualiza os campos com os valores.
            document.getElementById('ruaO').value=(conteudo.logradouro);
            document.getElementById('bairroO').value=(conteudo.bairro);
            document.getElementById('cidadeO').value=(conteudo.localidade);
            
        } //end if.
        else {
            //CEP não Encontrado.
            limpa_formulário_cep();
            alert("CEP não encontrado.");
        }
    }
    function meu_callbackDestino(conteudo) {
        if (!("erro" in conteudo)) {
            //Atualiza os campos com os valores.
            document.getElementById('ruaD').value=(conteudo.logradouro);
            document.getElementById('bairroD').value=(conteudo.bairro);
            document.getElementById('cidadeD').value=(conteudo.localidade);
            
        } //end if.
        else {
            //CEP não Encontrado.
            limpa_formulário_cep();
            alert("CEP não encontrado.");
        }
    }
        
    function pesquisacepDestino(valor) {

        //Nova variável "cep" somente com dígitos.
        var cep = valor.replace(/\D/g, '');

        //Verifica se campo cep possui valor informado.
        if (cep != "") {

            //Expressão regular para validar o CEP.
            var validacep = /^[0-9]{8}$/;

            //Valida o formato do CEP.
            if(validacep.test(cep)) {

                //Preenche os campos com "..." enquanto consulta webservice.
                document.getElementById('ruaD').value="...";
                document.getElementById('bairroD').value="...";
                document.getElementById('cidadeD').value="...";
                
                

                //Cria um elemento javascript.
                var script = document.createElement('script');

                //Sincroniza com o callback.
                script.src = 'http://viacep.com.br/ws/'+ cep + '/json/?callback=meu_callbackDestino';

                //Insere script no documento e carrega o conteúdo.
                document.body.appendChild(script);
                document.getElementById("numD").focus();

                

            } //end if.
            else {
                //cep é inválido.
                limpa_formulário_cep();
                alert("Formato de CEP inválido.");
            }
        } //end if.
        else {
            //cep sem valor, limpa formulário.
            limpa_formulário_cep();
        }
    };
     function pesquisacepOrigem(valor) {

        //Nova variável "cep" somente com dígitos.
        var cep = valor.replace(/\D/g, '');

        //Verifica se campo cep possui valor informado.
        if (cep != "") {

            //Expressão regular para validar o CEP.
            var validacep = /^[0-9]{8}$/;

            //Valida o formato do CEP.
            if(validacep.test(cep)) {

                //Preenche os campos com "..." enquanto consulta webservice.
                document.getElementById('ruaO').value="...";
                document.getElementById('bairroO').value="...";
                document.getElementById('cidadeO').value="...";
                
                

                //Cria um elemento javascript.
                var script = document.createElement('script');

                //Sincroniza com o callback.
                script.src = 'http://viacep.com.br/ws/'+ cep + '/json/?callback=meu_callbackOrigem';

                //Insere script no documento e carrega o conteúdo.
                document.body.appendChild(script);
                document.getElementById("numO").focus();

            } //end if.
            else {
                //cep é inválido.
                limpa_formulário_cep();
                alert("Formato de CEP inválido.");
            }
        } //end if.
        else {
            //cep sem valor, limpa formulário.
            limpa_formulário_cep();
        }
    };

    </script>
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
                        
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"></a></li>
                        <li><a href="../login_cliente.jsp">Logout</a></li>
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
    <body>
        
        <%Cliente cliente = (Cliente) session.getAttribute("clienteAutenticado");%>
        <%Agenda_Veiculo agenda = (Agenda_Veiculo) session.getAttribute("dados_para_cadastro_os");%>
        <%Pacote pacote = (Pacote) session.getAttribute("pacote_os");%>
        <br>
        <br>
        <form action="<%=Conf.getCaminhoContexto()%>ControleOrdemServico" method="POST">
            <div id="main" class="container-fluid">
                <h3 class="page-header">Envio</h3>
                <div id="main" class="container-fluid">
                    <h3>Informe o endereço de origem </h3>
<!--                    <div class="display">{{city}}</div>-->
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label onkeypress="this.value=''" for="campo1">CEP </label>
                            <input type="text" required="" class="form-control" id="cepO" name="txtCep_O"
                                   size="10" maxlength="9" onblur="pesquisacepOrigem(this.value);"><br/>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-4">
                                <label for="campo2">Rua </label>
                                <input type="text" required class="form-control" id="ruaO" name="txtRua_O"><br/>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-4">
                                    <label for="campo3">Numero </label>
                                    <input type="number"  required="" class="form-control"id="numO" name="txtNumero_O"><br/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label for="campo4">Cidade </label>
                            <input type="text" required class="form-control" name="txtCidade_O"id="cidadeO"><br/>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-4">
                                <label for="campo5">Bairro </label>
                                <input type="text" required class="form-control" name="txtBairro_O" id="bairroO"><br/>
                            </div>	
                        </div>
                    </div>
                    <h3> Informe o endereço de destino </h3>
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label for="campo6">CEP </label>
                            <input type="text" required class="form-control" id="cepD" name="txtCep_D"
                                   size="10" maxlength="9" onblur="pesquisacepDestino(this.value);"><br/>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-4">
                                <label for="campo7">Rua </label>
                                <input type="text" required class="form-control" id="ruaD" name="txtRua_D"><br/>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-4">
                                    <label for="campo8">Numero </label>
                                    <input type="number" required onblur="CarregarMapa()" class="form-control"  id="numD" name="txtNumero_D"><br/>
                                </div>   
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label for="campo9">Cidade </label>
                            <input type="text" required class="form-control" name="txtCidade_D" id="cidadeD"><br/>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-4">
                                <label for="campo10">Bairro </label>
                                <input type="text" required="" class="form-control" name="txtBairro_D" id="bairroD"><br/>
                            </div>
                        </div>   
                    </div>
                </div>
                <br>
                
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label for="campo15">KM Percorrido </label>
                            <input type="text" required  hidden class="form-control" id="distancia" name="txtKmPercorrido" readonly ><br/>
                        </div>
                    </div>
                </div>
            </div>
            <div id="map"></div>
            <div id="output"></div>
            <input type="text" hidden id="cliente" name ="txtIdCliente" value="<%=cliente.getId()%>" ></br>
            <input onclick="Alerta()" type="submit"  value="Cadastrar" name="acao" ><button onclick="cancelaOs()" id="cancelarOs">  <a href="<%=Conf.getCaminhoContexto()%>ControleOrdemServico?acao=CancelaOs&idPacote=<%=pacote.getId()%>&idAgenda=<%=agenda.getId()%>">Cancelar Frete</a> </button>
        </form>
        
    <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</form>

</body>
<script>
      function CarregarMapa() {
        var bounds = new google.maps.LatLngBounds;
        var markersArray = [];

        //var origin1 = {lat: 55.93, lng: -3.118};
        var origin1 = document.getElementById("ruaO").value.toString() + ", " +document.getElementById("numO").value.toString() +", " +document.getElementById("cidadeO").value.toString();
        
        var destinationA = document.getElementById("ruaD").value.toString() + ", " +document.getElementById("numD").value.toString()+", " +document.getElementById("cidadeD").value.toString();

        var destinationIcon = 'https://chart.googleapis.com/chart?' +
            'chst=d_map_pin_letter&chld=D|FF0000|000000';
        var originIcon = 'https://chart.googleapis.com/chart?' +
            'chst=d_map_pin_letter&chld=O|FFFF00|000000';
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 55.53, lng: 9.4},
          zoom: 10
        });
        var geocoder = new google.maps.Geocoder;

        var service = new google.maps.DistanceMatrixService;
        service.getDistanceMatrix({
          origins: [origin1],
          destinations: [destinationA],
          travelMode: 'DRIVING',
          unitSystem: google.maps.UnitSystem.METRIC,
          avoidHighways: false,
          avoidTolls: false
        }, function(response, status) {
          if (status !== 'OK') {
            alert('Error was: ' + status);
          } else {
            var originList = response.originAddresses;
            var destinationList = response.destinationAddresses;
            var outputDiv = document.getElementById('output');
            outputDiv.innerHTML = '';
            deleteMarkers(markersArray);

            var showGeocodedAddressOnMap = function(asDestination) {
              var icon = asDestination ? destinationIcon : originIcon;
              return function(results, status) {
                if (status === 'OK') {
                  map.fitBounds(bounds.extend(results[0].geometry.location));
                  markersArray.push(new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location,
                    icon: icon
                  }));
                } else {
                  alert('Geocode was not successful due to: ' + status);
                }
              };
            };

            for (var i = 0; i < originList.length; i++) {
              var results = response.rows[i].elements;
              geocoder.geocode({'address': originList[i]},
                  showGeocodedAddressOnMap(false));
              for (var j = 0; j < results.length; j++) {
                geocoder.geocode({'address': destinationList[j]},
                    showGeocodedAddressOnMap(true));
                outputDiv.innerHTML += originList[i] + '<br> ' + destinationList[j] +
                    ': ' + results[j].distance.text + ' <br> Tempo previsto em <br> ' +
                    results[j].duration.text + '<br>';
					document.getElementById('distancia').value = results[j].distance.text;
              }
            }
          }
        });
      }

      function deleteMarkers(markersArray) {
        for (var i = 0; i < markersArray.length; i++) {
          markersArray[i].setMap(null);
        }
        markersArray = [];
      }
      
      function cancelaOs(){
          var x;
          var r=confirm("Deseja mesmo cancelar o frete ?");
          
          if(r==true){
              x="Frete Cancelado !";
          }
          document.getElementById("cancelarOs").innerHTML=x;
      }
      
      function Alerta(){
          alert("Frete cadastrado com sucesso !")
      }
    </script>
    <footer id="footer">
      <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

  <script>
     CKEDITOR.replace( 'editor1' );
 </script>
    
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAY81ggmcwp8gugYqYdii0fyLt6EvywEp4">
//    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAY81ggmcwp8gugYqYdii0fyLt6EvywEp4&callback=initMap">
    </script>
    
    <!--<script>
    var app = new Vue({
        el: "#app",
        data: {
            city: "",
            cep: "08775005",
            error: ""
        },
        methods: {
            getCity: function () {
                var self = this;
                $.getJSON("https://viacep.com.br/ws/" + this.cep + "/json", function (result) {
                    if (("erro" in result)) {
                        self.error = "CEP não encontrado";
                        self.city = "";
                        $(".error").addClass("no");
                    } else {
                        self.city = result.logradouro + ", " + result.bairro + " - " + result.localidade + "/" + result.uf;
                        $(".display").addClass("animated fadeInDown");
                    }
                    console.log(result);
                });
            }
        },
        watch: {
            cep: function () {
                if (this.cep.length === 8) {
                    this.getCity();
                    this.error = "";
                    $(".error").removeClass("no");
                }
                if (this.cep.length < 8) {
                    this.city = "";
                    this.error = "CEP Inválido";
                    $(".error").addClass("no");
                    $(".display").removeClass("animated fadeInDown");
                }
            }
        },
        mounted: function () {
            this.getCity();
        }
    })
</script>-->

</html>
