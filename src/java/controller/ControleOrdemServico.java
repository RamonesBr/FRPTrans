 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Agenda_Veiculo;
import model.Agenda_VeiculoDAO;
import model.Cliente;
import model.ClienteDAO;
import model.Email;
import model.Endereco_Destino;
import model.Endereco_DestinoDAO;
import model.Endereco_Origem;
import model.Endereco_OrigemDAO;
import model.Endereco_Viagem;
import model.Endereco_ViagemDAO;
import model.Ordem_Servico;
import model.Ordem_ServicoDAO;
import model.Pacote;
import model.PacoteDAO;
import model.Status_Frete;
import model.Usuario;
import model.UsuarioDAO;
import model.Veiculo;
import model.VeiculoDAO;
import model.Viagem;
import model.ViagemDAO;
import util.Conf;
import util.Validacao;

/**
 *
 * @author Ramon Cordeiro
 */
public class ControleOrdemServico extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            String acao = Validacao.Formulario(request.getParameter("acao"));

            if (acao.equals("Cadastrar")) {
                cadastraOrdemServico(request, response);
            } else if (acao.equals("ListarTodasOs")) {
                listarTodasOs(request, response);
            } else if (acao.equals("CancelaOs")) {
                cancelaFrete(request, response);
            } else if (acao.equals("ListarOsCliente")) {
                listaOsCliente(request, response);
            }else if (acao.equals("Combinar")){
                insereViagemCombinada(request, response);
            }
            else if (acao.equals("VerMais")){
                consultaViagemRefinada(request, response);         
            }else if (acao.equals("Alterar")){
                alterarDataVeicEdicao(request, response);
            }else if (acao.equals("ConfirmaViagem")){
                confirmaViagem(request, response);
            }else if(acao.equals("EncerraViagem")){
                encerraViagem(request, response);
            }else if(acao.equals("Consultar")){
                exibeAgendaPorStatus(request, response);
            }else if(acao.equals("RelatorioEntreDatas")){
                exibeEntreDatas(request, response);
            }
        } catch (Exception e) {
                System.out.println("erro ao cadastrar" + e.getMessage());
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void cadastraOrdemServico(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException {
        //Recupera dados Endereço Origem voce só precisa chamar aquela classe q criamos agora antes dos requests
        String cepOrigem = Validacao.Formulario(Validacao.Formulario(request.getParameter("txtCep_O")));//abre um form no chrome q o usuario cadastre alguma coisa
        String ruaOrigem = Validacao.Formulario(request.getParameter("txtRua_O"));
        int numeroOrigem = Integer.parseInt(Validacao.Formulario(request.getParameter("txtNumero_O")));
        String cidadeOrigem = Validacao.Formulario(request.getParameter("txtCidade_O"));
        String bairroOrigem = Validacao.Formulario(request.getParameter("txtBairro_O"));

        //Recupera dados Endereco Deestino 
        String cepDestino = Validacao.Formulario(request.getParameter("txtCep_D"));
        String ruaDestino = Validacao.Formulario(request.getParameter("txtRua_D"));
        String numeroDestino = Validacao.Formulario(request.getParameter("txtNumero_D"));
        String cidadeDestino = Validacao.Formulario(request.getParameter("txtCidade_D"));
        String bairroDestino = Validacao.Formulario(request.getParameter("txtBairro_D"));

        //Recupera dados Ordem Serviço
        String dataKmPercorrido = Validacao.Formulario(request.getParameter("txtKmPercorrido").replace("km", ""));
        dataKmPercorrido = dataKmPercorrido.replace(",", ".");
        //Recuepra o Id cliente
        String idCliente = Validacao.Formulario(request.getParameter("txtIdCliente"));

        //recupero dados na sessão
        HttpSession dados_para_cadastro_os = request.getSession();
        HttpSession pacote_os = request.getSession();
        HttpSession veiculo_os = request.getSession();
            Agenda_Veiculo data_dados = (Agenda_Veiculo) dados_para_cadastro_os.getAttribute("dados_para_cadastro_os");
        Pacote pacote_ordem_servico = (Pacote) pacote_os.getAttribute("pacote_os");
        Veiculo veic_os = (Veiculo) veiculo_os.getAttribute("veiculo_os");

        //Instâncio todos os objetos
        Cliente cliente = new Cliente();
        Ordem_Servico os = new Ordem_Servico();
        Usuario usuario = new Usuario();
        Endereco_Origem eO = new Endereco_Origem();
        Endereco_Destino eD = new Endereco_Destino();
        Agenda_Veiculo agVeic = new Agenda_Veiculo();
        Viagem viagem  = new Viagem();

        Endereco_OrigemDAO daoEo = new Endereco_OrigemDAO();
        Endereco_DestinoDAO daoED = new Endereco_DestinoDAO();
        Ordem_ServicoDAO daoOs = new Ordem_ServicoDAO();
        UsuarioDAO usuDAO = new UsuarioDAO();
        Agenda_VeiculoDAO agDAO = new Agenda_VeiculoDAO();
        ViagemDAO viagemDAO =new ViagemDAO();

        //Set em todos os objetos
        eO.setCep(cepOrigem);
        eO.setRua(ruaOrigem);
        eO.setNumero(numeroOrigem);
        eO.setBairro(bairroOrigem);
        eO.setCidade(cidadeOrigem);

        eD.setCep(cepDestino);
        eD.setRua(ruaDestino);
        eD.setNumero(Integer.parseInt(numeroDestino));
        eD.setBairro(bairroDestino);
        eD.setCidade(cidadeDestino);
//mano é aquele erro la de conversão ...  q modáfoka vamo ve saporra ai
        os.setKm_percorrido(Double.parseDouble(dataKmPercorrido)); //KILOMETRAGEM EXTRAIDA DO PONTO A AO PONTO B
        os.setCliente(data_dados.getCliente()); // CLIENTE DA SESSÃO
        os.setVeiculo(data_dados.getVeiculo()); // VEICULO SELECIONADO 
        os.setData_partida(data_dados.getData_disp()); // DATA AGENDADA
        os.setDimensao_pacote(pacote_ordem_servico.getId()); //PACOTE CADASTRADO

        daoEo.cadastraNovoEnderecoOrigem(eO); // Cadastra Endereco de Origem
        daoED.cadastraNovoEnderecoDestino(eD);// Cadastra Endereco de Destino

        //cadastra Ordem Servico passando todos obj na assinatura
        daoOs.cadastrarOrdemServico(os, eO, eD, pacote_ordem_servico);

        //Calcula a viagem 
        veic_os.getTipo(); // Recupera o veiculo alocado para comparar o valor adequado
        os.calculaViagem(os, veic_os);
        daoOs.setValorViagem(os);

        /*Cadastra o ID da O.S na Agenda Veiculo
        data_dados.setId(data_dados.getId());

        agDAO.setOsAgendaVeiculo(os, data_dados);
        */
        
        //Altera Status da Agenda e da Ordem_Servico
        
        data_dados.setStatus_agenda(Status_Frete.PENDENTE); //lembrando que data_dados é minha sessão da agenda_veiculo gravada
        os.setStatus_os(Status_Frete.PENDENTE);
        
        agDAO.setStatusAgenda(data_dados);
        daoOs.setStatusOs(os);
        
        //Cadadtra agenda_veiculo_viagem_ordem_servico
        
        viagemDAO.cadastraViagem(data_dados, os);
        
        
        RequestDispatcher rd = request.getRequestDispatcher("cliente/painel_cliente.jsp");
        rd.forward(request, response);
    }

    private void listarTodasOs(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, ServletException, IOException {

        Ordem_ServicoDAO dao = new Ordem_ServicoDAO();

        List<Ordem_Servico> todasOs = dao.listarOrdemServico();

        request.setAttribute("retornaTodasOs", todasOs);
        RequestDispatcher rd = request.getRequestDispatcher("/logistica/manter_ordem_servico.jsp");
        rd.forward(request, response);

    }

    private void cancelaFrete(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, ServletException, IOException {

        int idPacote = (Integer.parseInt(Validacao.Formulario(request.getParameter("idPacote"))));
        int idAgenda = (Integer.parseInt(Validacao.Formulario(request.getParameter("idAgenda"))));

        Agenda_Veiculo agenda = new Agenda_Veiculo();
        Pacote pacote = new Pacote();

        Agenda_VeiculoDAO agendaDAO = new Agenda_VeiculoDAO();
        PacoteDAO pacoteDAO = new PacoteDAO();

        agenda.setId(idAgenda);
        pacote.setId(idPacote);

        agendaDAO.excluirAgenda(agenda);
        pacoteDAO.excluirPacote(pacote);

         response.sendRedirect(Conf.getCaminhoContexto() + "cliente/painel_cliente.jsp");
    }

    private void listaOsCliente(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException, ServletException {

        int idCliente = (Integer.parseInt(Validacao.Formulario(request.getParameter("idCliente"))));

        Cliente cliente = new Cliente();
        Ordem_ServicoDAO osDAO = new Ordem_ServicoDAO();

        cliente.setId(idCliente);
        List<Ordem_Servico> listarOs = osDAO.consultaOrdemServicoCliente(cliente);

        HttpSession retornaOsCliente = request.getSession();
        retornaOsCliente.setAttribute("retornaOsCliente", listarOs);

        response.sendRedirect(Conf.getCaminhoContexto() + "cliente/painel_cliente.jsp");

    }

    private void insereViagemCombinada(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException, ServletException {
        
        ViagemDAO viagemDAO =new ViagemDAO();
        Agenda_VeiculoDAO agendaDAO = new Agenda_VeiculoDAO();
           
        List<Viagem> base = new ArrayList<Viagem>();
        List<Viagem> nova_agenda = new ArrayList<Viagem>();
        Viagem vAux = new Viagem();
        
        
        String[] viagem = (request.getParameterValues("viagens")); // Recebe os ID de Agenda_Veiculo   
       
        List <Viagem> datasViagem = new ArrayList<Viagem>();
        for(int i=0; i<viagem.length ; i++){ 
            
        int id = Integer.parseInt(viagem[i]); 
        
        Viagem datas = new Viagem();   
        Viagem v = new Viagem();
        
        v.getAgenda_veiculo().setId(id); 
        
        
        datas = viagemDAO.consultaDatasParaComparacao(v);
        datasViagem.add(datas);
        }
        boolean erroDatas = false;
        for(int i =0; i<datasViagem.size()-1 ; i++ ){
            
            if(!datasViagem.get(i).getAgenda_veiculo().getData_agenda().equals(datasViagem.get(i+1).getAgenda_veiculo().getData_agenda()) ){
                
            
             
                 erroDatas = true;

                  }
        }
 
        if(erroDatas){
        
        HttpSession erroDatasIguais = request.getSession();
        erroDatasIguais.setAttribute("erroDatasIguais", "Erro ! Não é possível combinar datas iguais !");
        
       response.sendRedirect(Conf.getCaminhoContexto() + "logistica/principal_func_logistica.jsp");
        }else{
            double maiorPacote = 0; 
      
        
           for(int i=0; i<viagem.length ; i++){    //Começo a varrer os Id das Agenda_Viagem
           
           
            int id = Integer.parseInt(viagem[i]);
            
            
           
            Viagem v = new Viagem();
          
           v.getAgenda_veiculo().setId(id); 
          
           v = viagemDAO.consultarPorIdOrdemServico(v);  //Consulto dados pela O.S para retornar dados pertinentes
           v.getAgenda_veiculo().setStatus_agenda(Status_Frete.INDISPONIVEL); //Indisponibiliza as Agenda_veiculo
           agendaDAO.setStatusAgenda(v.getAgenda_veiculo());//
           
           v.setStatus_viagem(Status_Frete.INDISPONIVEL);// Indisponibiliza as Viagens
           viagemDAO.alterarStatusViagens(v);
          
            vAux = v;
            nova_agenda.add(vAux);
          
           if(v.getOrdem_servico().getMetros_cubico() > maiorPacote){
               
               maiorPacote = v.getOrdem_servico().getMetros_cubico(); 
               base.add(v);  // 
               
           }
           viagemDAO.cadastraNovasViagens(v);
           
            }
       
       int idAgendaNova = agendaDAO.cadastraAgendaNova(vAux);
           
           for (int j = 0; j < nova_agenda.size(); j++) {
               nova_agenda.get(j).getAgenda_veiculo().setVeiculo(vAux.getAgenda_veiculo().getVeiculo());
              
           }
         
           
           for (int j = 0; j < nova_agenda.size(); j++) {
               
               
               nova_agenda.get(j).getAgenda_veiculo().setId(idAgendaNova);
               nova_agenda.get(j).setStatus_viagem(Status_Frete.PENDENTE);
               viagemDAO.alteraViagensNovas(nova_agenda.get(j)); // 
               
           }
           
      
      
        response.sendRedirect(Conf.getCaminhoContexto() + "logistica/principal_func_logistica.jsp");
            
        }
       
       
        

        }

    private void consultaViagemRefinada(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, ServletException, IOException {
        
     String[] idviagem = (request.getParameterValues("viagens2")); // Recebe os ID de Agenda_Veiculo
        
      //  List<Viagem> viagem = new ArrayList<Viagem>(); 
        
        
        ViagemDAO viagemDAO = new ViagemDAO();
        List<Viagem> retornaViagens= new ArrayList<Viagem>();
       
        
        for(int i = 0; i<idviagem.length ; i++){
            
             int id = Integer.parseInt(idviagem[i]);
              List<Viagem> viagem = new ArrayList <Viagem>();
             
             Viagem v = new Viagem();
              
             v.getAgenda_veiculo().setId(id);
             viagem = viagemDAO.consultaDetalhesViagemFuncLogistica(v);
           
            
             
             
            
             for (int j = 0; j< viagem.size(); j++) {
                
               Viagem v2 = new Viagem();
               
               v2 = viagem.get(j);
               
               
               retornaViagens.add(v2);
            }

            
             }
        


        HttpSession teste = request.getSession();
        teste.setAttribute("retornaExibirMaisViagens", retornaViagens);

        response.sendRedirect(Conf.getCaminhoContexto()+"logistica/manter_viagens.jsp");

          
    }    

    private void alterarDataVeicEdicao(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {
        int idAgenda = (Integer.parseInt(Validacao.Formulario(request.getParameter("idAgenda"))));
        int idOs = (Integer.parseInt(Validacao.Formulario(request.getParameter("idOrdemServico"))));
        int idVeiculo = (Integer.parseInt(Validacao.Formulario(request.getParameter("idVeiculo"))));
        String data_agenda = Validacao.Formulario(request.getParameter("dataAgenda"));
        
        
        Viagem viagem = new Viagem();
        ViagemDAO viagemDAO = new ViagemDAO();
        
        viagem.getAgenda_veiculo().setId(idAgenda);
        viagem.getOrdem_servico().setId(idOs);
        viagem.getAgenda_veiculo().setVeiculo(idVeiculo);
        viagem.getAgenda_veiculo().setData_agenda(data_agenda);
        
        viagemDAO.alterarDataAgendaVeiculoFuncLog(viagem);
        viagemDAO.alterarDataPartidaOsFuncLog(viagem);
        viagemDAO.alterarVeiculoAgendaFuncEdicao(viagem);
        
        
        
        List<Viagem> v = new ArrayList<Viagem>();
        
        v = viagemDAO.consultaIdOsEdicaoFuncLog(viagem);
        
        
         for(int i = 0; i<v.size() ; i++){
             
            Viagem v2 = new Viagem();
            ViagemDAO vDAO = new ViagemDAO();
            
            v2.getAgenda_veiculo().setData_agenda(data_agenda);        
            v2 = v.get(i);
            vDAO.consultaIdOsEdicaoFuncLog(v2);
            
             
         }
        
         response.sendRedirect("logistica/principal_func_logistica.jsp");
    }

    private void confirmaViagem(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {
        
        int idAgenda = Integer.parseInt(Validacao.Formulario(request.getParameter("idAgenda")));
        
        Cliente cliente = new Cliente();
        ClienteDAO clienteDAO = new ClienteDAO();
        List<Cliente> c = new ArrayList<Cliente>();
        List<Viagem> v = new ArrayList<Viagem>();
        Viagem viagem = new Viagem();
        ViagemDAO viagemDAO = new ViagemDAO();
        
        viagem.getAgenda_veiculo().setId(idAgenda);
        
        c = clienteDAO.consultarEmailCliente(viagem);
        
        for(int i = 0 ; i<c.size(); i++){
            
            String email = c.get(i).getEmail();
            String nomeCli = c.get(i).getNome();
        Email e = new Email();
        e.setNomeDestinatario(nomeCli);
        e.setEmailDestinatario(email);
        e.setAssunto("FRPTrans informa: Seu frete foi iniciado");
        e.setMensagem("Seu frete foi enviado com sucesso !\n "
                + "E deve chegar em breve... \n"
                + "FRPTrans agradece a preferência...");
        e.enviar();
        }
        
        viagem.getAgenda_veiculo().setStatus_agenda(Status_Frete.ANDAMENTO );
        viagem.getOrdem_servico().setStatus_os(Status_Frete.ANDAMENTO);
        viagem.setStatus_viagem(Status_Frete.ANDAMENTO);
        
        viagemDAO.alterarStatusAgendaQuandoConfirma(viagem);
        viagemDAO.alterarStatusViagemQuandoConfirma(viagem);
        
        v = viagemDAO.consultaIdOsEdicaoFuncLog(viagem);
        
        for(int i=0; i<v.size(); i ++){
            
            Viagem v2 = new Viagem();
            v2.getOrdem_servico().setId(c.get(i).getId());
            
            viagemDAO.alterarStatusOsQuandoConfirma(viagem);
            
            
        }
        
        response.sendRedirect("logistica/principal_func_logistica.jsp");
        
        
    }
    private void encerraViagem(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {
        
        int idAgenda = Integer.parseInt(Validacao.Formulario(request.getParameter("idAgenda")));
        
        Cliente cliente = new Cliente();
        ClienteDAO clienteDAO = new ClienteDAO();
        List<Cliente> c = new ArrayList<Cliente>();
        List<Viagem> v = new ArrayList<Viagem>();
        Viagem viagem = new Viagem();
        ViagemDAO viagemDAO = new ViagemDAO();
        
        viagem.getAgenda_veiculo().setId(idAgenda);
        
        c = clienteDAO.consultarEmailCliente(viagem);
        
        for(int i = 0 ; i<c.size(); i++){
            
            String email = c.get(i).getEmail();
            String nomeCli = c.get(i).getNome();
        Email e = new Email();
        e.setNomeDestinatario(nomeCli);
        e.setEmailDestinatario(email);
        e.setAssunto("FRPTrans informa: Seu frete foi encerrado");
        e.setMensagem("Seu frete foi encerrado !\n "
                + "Obrigado ! \n");
        e.enviar();
        }
        
        viagem.getAgenda_veiculo().setStatus_agenda(Status_Frete.ENCERRADO );
        viagem.getOrdem_servico().setStatus_os(Status_Frete.ENCERRADO);
        viagem.setStatus_viagem(Status_Frete.ENCERRADO);
        
        viagemDAO.alterarStatusAgendaQuandoConfirma(viagem);
        viagemDAO.alterarStatusViagemQuandoConfirma(viagem);
        
        v = viagemDAO.consultaIdOsEdicaoFuncLog(viagem);
        
        for(int i=0; i<v.size(); i ++){
            
            Viagem v2 = new Viagem();
            v2.getOrdem_servico().setId(c.get(i).getId());
            
            viagemDAO.alterarStatusOsQuandoConfirma(viagem);
            
            
        }
        
        response.sendRedirect("logistica/principal_func_logistica.jsp");
        
        
    }

    private void exibeAgendaPorStatus(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {
        
        String status = Validacao.Formulario(request.getParameter("statusCombo"));
        
        
        Agenda_Veiculo agenda = new Agenda_Veiculo();
        Agenda_VeiculoDAO agDAO = new Agenda_VeiculoDAO();
        List<Agenda_Veiculo> agList = new ArrayList<Agenda_Veiculo>();
       
        if(status.equalsIgnoreCase("ENCERRADO")){
        
            agList = agDAO.consultaTodasAgendasPorDataEncerrado();
    
        }else if(status.equalsIgnoreCase("PENDENTE")){
            agList = agDAO.consultaTodasAgendasPorDataPendente();
        }
        else if(status.equalsIgnoreCase("ANDAMENTO")){
            agList = agDAO.consultaTodasAgendasPorDataAndamento();
        }

        HttpSession retornaListaAgenda = request.getSession();
        retornaListaAgenda.setAttribute("retornaFiltroSelecionado", agList);
        
        response.sendRedirect(Conf.getCaminhoContexto() + "logistica/exibePorStatus.jsp");

        
        
    }

    private void exibeEntreDatas(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {
       
        String data1 = Validacao.Formulario(request.getParameter("Data1"));
        String data2 = Validacao.Formulario(request.getParameter("Data2"));
        String status = Validacao.Formulario(request.getParameter("status"));
        
        
        List<Viagem> viagem = new ArrayList<Viagem>();
        ViagemDAO viagemDAO = new ViagemDAO();
        
        viagem = viagemDAO.consultaDetalhesViagemFuncAdmin(data1, data2,status);
        
        HttpSession retornaListaAgenda = request.getSession();
        retornaListaAgenda.setAttribute("retornaDadosViagemAdm", viagem);
        
        
        response.sendRedirect(Conf.getCaminhoContexto() + "admin/principal_admin.jsp");
        
    }
    
    
    
    }


