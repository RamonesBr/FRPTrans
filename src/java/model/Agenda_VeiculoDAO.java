/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.ConectaBanco;

/**
 *
 * @author Ramon Cordeiro
 */
public class Agenda_VeiculoDAO {
    
    private static final String VERIFICA_DISP_AGENDA = "select * from agenda_veiculo where  veiculo = ? and data_agenda = CAST(? as Date)";
    private static final String VERIFICA_PROX_AGENDA = "select cast(? as date)  + ? as dataDisponivel  from agenda_veiculo where veiculo =?";
    private static final String CADASTRA_AGENDA_VEIC = "insert into agenda_veiculo(veiculo,data_agenda) values (?,CAST(? as Date)) returning id";
    private static final String EXCLUI_AGENDA = "delete from agenda_veiculo where id=?";
    private static final String INSERE_OS_NA_AGENDA ="update agenda_veiculo set ordem_servico1 = ? where id=?";
    private static final String ALTERA_STATUS_AGENDA ="update agenda_veiculo set status=? where id=?";
    private static final String EXIBE_AGENDA_FUNC_LOGISTICA ="select distinct (agenda_veiculo.id) as numAgenda, veiculo.modelo, veiculo.placa, agenda_veiculo.data_agenda, agenda_veiculo.status " +
                                                             "from agenda_veiculo_viagem_ordem_servico as avos "+
                                                             "inner join agenda_veiculo on avos.agenda_veiculo = agenda_veiculo.id " +
                                                             "inner join ordem_servico on avos.ordem_servico = ordem_servico.id " +
                                                             "inner join endereco_origem on ordem_servico.endereco_origem = endereco_origem.id " +
                                                             "inner join endereco_destino on ordem_servico.endereco_destino = endereco_destino.id " +
                                                             "inner join cliente on ordem_servico.cliente  = cliente.id " +
                                                             "inner join veiculo on agenda_veiculo.veiculo = veiculo.id " +
                                                             "where agenda_veiculo.status='PENDENTE' or agenda_veiculo.status='ANDAMENTO' " +
                                                             "order by agenda_veiculo.data_agenda";
     private static final String EXIBE_AGENDA_FUNC_LOGIS_ENCERRADO ="select distinct (agenda_veiculo.id) as numAgenda, veiculo.modelo, veiculo.placa, agenda_veiculo.data_agenda, agenda_veiculo.status " +
                                                             "from agenda_veiculo_viagem_ordem_servico as avos "+
                                                             "inner join agenda_veiculo on avos.agenda_veiculo = agenda_veiculo.id " +
                                                             "inner join ordem_servico on avos.ordem_servico = ordem_servico.id " +
                                                             "inner join endereco_origem on ordem_servico.endereco_origem = endereco_origem.id " +
                                                             "inner join endereco_destino on ordem_servico.endereco_destino = endereco_destino.id " +
                                                             "inner join cliente on ordem_servico.cliente  = cliente.id " +
                                                             "inner join veiculo on agenda_veiculo.veiculo = veiculo.id " +
                                                             "where agenda_veiculo.status='ENCERRADO' " +
                                                             "order by agenda_veiculo.data_agenda";
     private static final String EXIBE_AGENDA_FUNC_LOGIS_ANDAMENTO ="select distinct (agenda_veiculo.id) as numAgenda, veiculo.modelo, veiculo.placa, agenda_veiculo.data_agenda, agenda_veiculo.status " +
                                                             "from agenda_veiculo_viagem_ordem_servico as avos "+
                                                             "inner join agenda_veiculo on avos.agenda_veiculo = agenda_veiculo.id " +
                                                             "inner join ordem_servico on avos.ordem_servico = ordem_servico.id " +
                                                             "inner join endereco_origem on ordem_servico.endereco_origem = endereco_origem.id " +
                                                             "inner join endereco_destino on ordem_servico.endereco_destino = endereco_destino.id " +
                                                             "inner join cliente on ordem_servico.cliente  = cliente.id " +
                                                             "inner join veiculo on agenda_veiculo.veiculo = veiculo.id " +
                                                             "where agenda_veiculo.status='ANDAMENTO' " +
                                                             "order by agenda_veiculo.data_agenda";
     private static final String EXIBE_AGENDA_FUNC_LOGIS_PENDENTE ="select distinct (agenda_veiculo.id) as numAgenda, veiculo.modelo, veiculo.placa, agenda_veiculo.data_agenda, agenda_veiculo.status " +
                                                             "from agenda_veiculo_viagem_ordem_servico as avos "+
                                                             "inner join agenda_veiculo on avos.agenda_veiculo = agenda_veiculo.id " +
                                                             "inner join ordem_servico on avos.ordem_servico = ordem_servico.id " +
                                                             "inner join endereco_origem on ordem_servico.endereco_origem = endereco_origem.id " +
                                                             "inner join endereco_destino on ordem_servico.endereco_destino = endereco_destino.id " +
                                                             "inner join cliente on ordem_servico.cliente  = cliente.id " +
                                                             "inner join veiculo on agenda_veiculo.veiculo = veiculo.id " +
                                                             "where agenda_veiculo.status='ENCERRADO' " +
                                                             "order by agenda_veiculo.data_agenda";
                                                            
    private static final String INSERE_NOVA_AGENDA = "insert into agenda_veiculo (veiculo, data_agenda, status) values (?,CAST(? AS DATE),?) returning id ";
    private static final String RECUPERA_DATA_AGENDA = "select data_agenda from agenda_veiculo where id = ? "; 
    
    
     public boolean verificaDispAgenda(Agenda_Veiculo agVeic) throws SQLException { 
         boolean retorno = false;
         Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(VERIFICA_DISP_AGENDA);
        comando.setInt(1, agVeic.getVeiculo());
        comando.setString(2, agVeic.getData_agenda());

        ResultSet resultado = comando.executeQuery();
        
        if(resultado.next()){
            retorno=true;
        }
            return retorno;
     }
     
     public String verificaProxAgenda(Agenda_Veiculo agVeic, int i) throws SQLException{
        String dataDisp = null;
         Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(VERIFICA_PROX_AGENDA); 
        comando.setString(1, agVeic.getData_agenda());
        comando.setInt(2, i);
        comando.setInt(3, agVeic.getVeiculo());
        

        ResultSet resultado = comando.executeQuery();
        
        if(resultado.next()){
            dataDisp = resultado.getString("dataDisponivel");
        }
 
      return dataDisp;   
     }
     
     public void cadastraAgendaVeic(Agenda_Veiculo agVeic) throws SQLException{
        
       
        Connection conexao = null;
        PreparedStatement comando = null;
        try { 
        conexao = ConectaBanco.getConexao();
        comando = conexao.prepareStatement(CADASTRA_AGENDA_VEIC);
         
        
        comando.setInt(1, agVeic.getVeiculo());
        comando.setString(2, agVeic.getData_disp());
        

        ResultSet resultadoPk = comando.executeQuery(); 
        
        if(resultadoPk.next()){
                    agVeic.setId(resultadoPk.getInt("id")); 
                }
        //nao tinha salvo rs
        }catch (SQLException sqlErro) {
            System.out.println("erro ZIKA"+sqlErro);    
            throw new RuntimeException(sqlErro); 
        } finally {
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);

                }
            }
        }
     }
      public void excluirAgenda(Agenda_Veiculo agenda) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(EXCLUI_AGENDA);

            pstm.setInt(1, agenda.getId());

            pstm.execute();

        } catch (Exception e) {

            e.printStackTrace();
        } finally {

            //Fecha as conexões
            try {
                if (pstm != null) {

                    pstm.close();
                }

                if (conn != null) {
                    conn.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
        
    }
      
      public void setOsAgendaVeiculo(Ordem_Servico os, Agenda_Veiculo agenda) {

        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(INSERE_OS_NA_AGENDA);

            pstm.setDouble(1, os.getId());

            pstm.setInt(2, agenda.getId());

            pstm.execute();

        } catch (Exception e) {

            e.printStackTrace();
        } finally {

            //Fecha as conexões
            try {
                if (pstm != null) {

                    pstm.close();
                }

                if (conn != null) {
                    conn.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
        
    }
      public void setStatusAgenda(Agenda_Veiculo agenda) {

        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ALTERA_STATUS_AGENDA);

            pstm.setString(1, agenda.getStatus_agenda().toString() );

            pstm.setInt(2, agenda.getId());

            pstm.execute();

        } catch (Exception e) {

            e.printStackTrace();
        } finally {

            //Fecha as conexões
            try {
                if (pstm != null) {

                    pstm.close();
                }

                if (conn != null) {
                    conn.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
        
    }
       public List<Agenda_Veiculo> consultaTodasAgendasPorData() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(EXIBE_AGENDA_FUNC_LOGISTICA);
        ResultSet resultado = comando.executeQuery();
        

       List <Agenda_Veiculo> agenda_veiculo = new ArrayList <Agenda_Veiculo>();
        while (resultado.next()) {
            Agenda_Veiculo agV = new Agenda_Veiculo();
            agV.setId(resultado.getInt("numagenda"));
            agV.setModelo_veic(resultado.getString("modelo"));
            agV.setPlaca_veic(resultado.getString("placa"));
            agV.setData_agenda(resultado.getString("data_agenda"));
            agV.setStatus(resultado.getString("status"));
            agenda_veiculo.add(agV);
        }

          con.close();
          return agenda_veiculo;
}
    
       
       
       public int cadastraAgendaNova(Viagem viagem) throws SQLException {

        Connection conexao = null;
        PreparedStatement comando = null;
        int retornaId = 0;
        try {
            conexao = ConectaBanco.getConexao();
            comando = conexao.prepareStatement(INSERE_NOVA_AGENDA);
            
            viagem.getAgenda_veiculo().setStatus_agenda(Status_Frete.PENDENTE );
            
            comando.setInt(1, viagem.getAgenda_veiculo().getVeiculo() );
            comando.setString(2, viagem.getAgenda_veiculo().getData_agenda());
            comando.setString(3, viagem.getAgenda_veiculo().getStatus_agenda().toString());

            ResultSet resultadoPk = comando.executeQuery();

            if (resultadoPk.next()) {
                retornaId = resultadoPk.getInt("id");
            }
            
        } catch (SQLException sqlErro) {
            System.out.println("erro ZIKA" + sqlErro);
            throw new RuntimeException(sqlErro);
        } finally {
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);

                }
            }
        }
        return retornaId;
    }
       
       public List<Agenda_Veiculo> consultaTodasAgendasPorDataEncerrado() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(EXIBE_AGENDA_FUNC_LOGIS_ENCERRADO);
        ResultSet resultado = comando.executeQuery();
        

       List <Agenda_Veiculo> agenda_veiculo = new ArrayList <Agenda_Veiculo>();
        while (resultado.next()) {
            Agenda_Veiculo agV = new Agenda_Veiculo();
            agV.setId(resultado.getInt("numagenda"));
            agV.setModelo_veic(resultado.getString("modelo"));
            agV.setPlaca_veic(resultado.getString("placa"));
            agV.setData_agenda(resultado.getString("data_agenda"));
            agV.setStatus(resultado.getString("status"));
            agenda_veiculo.add(agV);
        }

          con.close();
          return agenda_veiculo;
} 
            public List<Agenda_Veiculo> consultaTodasAgendasPorDataPendente() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(EXIBE_AGENDA_FUNC_LOGIS_PENDENTE);
        ResultSet resultado = comando.executeQuery();
        

       List <Agenda_Veiculo> agenda_veiculo = new ArrayList <Agenda_Veiculo>();
        while (resultado.next()) {
            Agenda_Veiculo agV = new Agenda_Veiculo();
            agV.setId(resultado.getInt("numagenda"));
            agV.setModelo_veic(resultado.getString("modelo"));
            agV.setPlaca_veic(resultado.getString("placa"));
            agV.setData_agenda(resultado.getString("data_agenda"));
            agV.setStatus(resultado.getString("status"));
            agenda_veiculo.add(agV);
        }

          con.close();
          return agenda_veiculo;
} 
          public List<Agenda_Veiculo> consultaTodasAgendasPorDataAndamento() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(EXIBE_AGENDA_FUNC_LOGIS_ANDAMENTO);
        ResultSet resultado = comando.executeQuery();
        

       List <Agenda_Veiculo> agenda_veiculo = new ArrayList <Agenda_Veiculo>();
        while (resultado.next()) {
            Agenda_Veiculo agV = new Agenda_Veiculo();
            agV.setId(resultado.getInt("numagenda"));
            agV.setModelo_veic(resultado.getString("modelo"));
            agV.setPlaca_veic(resultado.getString("placa"));
            agV.setData_agenda(resultado.getString("data_agenda"));
            agV.setStatus(resultado.getString("status"));
            agenda_veiculo.add(agV);
        }

          con.close();
          return agenda_veiculo;
} 
}
