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
public class ViagemDAO {

    private static final String INSERE_VIAGEM_NOVA = "insert into agenda_veiculo_viagem_ordem_servico(ordem_servico,status) values(?,?) returning id";
    private static final String INSERE_VIAGEM = "insert into agenda_veiculo_viagem_ordem_servico(agenda_veiculo,ordem_servico,status) values(?,?,?) returning id";
    private static final String CONSULTA_OS_DA_AGENDA = "select agenda_veiculo_viagem_ordem_servico.id ,agenda_veiculo_viagem_ordem_servico.ordem_servico,agenda_veiculo.data_agenda ,pacote.metros_cubicos, agenda_veiculo.veiculo " +
                                "from agenda_veiculo_viagem_ordem_servico " +
                                "inner join ordem_servico on agenda_veiculo_viagem_ordem_servico.ordem_servico  = ordem_servico.id " +
                                "inner join pacote on ordem_servico.dimensao_pacote = pacote.id " +
                                "inner join agenda_veiculo on agenda_veiculo_viagem_ordem_servico.agenda_veiculo = agenda_veiculo.id " + //vpior
                                "where agenda_veiculo_viagem_ordem_servico.agenda_veiculo = ?";
    private static final String INSERE_NOVA_AGENDA_VEICULO = "insert into agenda_veiculo(veiculo,data_agenda,status) values (?,CAST(?),'PENDENTE')returning id";
    private static final String ATUALIZA_STATUS_VIAGENS_ANTIGAS ="update agenda_veiculo_viagem_ordem_servico set status = ? where id=?";
    private static final String ATUALIZA_VIAGENS_NOVAS ="update agenda_veiculo_viagem_ordem_servico set agenda_veiculo=? where id=?";
    private static final String RECUPERA_0S_VIAGEM_QUANDO_CONFIRMA ="select avos.ordem_servico from agenda_veiculo_viagem_ordem_servico as avos where avos.agenda_veiculo = ? ";
    private static final String ATUALIZA_STATUS_AGENDA_VEICULO_QUANDO_CONFIRMA = "update agenda_veiculo set status=? where id=? ";
    private static final String ATUALIZA_STATUS_VIAGEM_QUANDO_CONFIRMA = "UPDATE agenda_veiculo_viagem_ordem_servico set status=? where agenda_veiculo=? ";
    private static final String ATUALIZA_STATUS_ORDEM_SERVICO_QUANDO_CONFIRMA = "UPDATE ordem_servico set status=? where id= ? ";
    private static final String EXIBE_DETALHES_VIAGEM_FUNC_LOG = "select agenda.id as agenda_veiculo, os.id as ordem_servico, cliente.nome, veiculo.modelo, veiculo.placa, os.valor_viagem, concat(endereco_origem.rua||', '||endereco_origem.numero||'- '||endereco_origem.bairro||'- '||endereco_origem.cidade) as EndOrigem,concat(endereco_destino.rua||', '||endereco_destino.numero||'- '||endereco_origem.bairro||'- '||endereco_origem.cidade) as EndDestino, " +
                                                                 "pacote.metros_cubicos, agenda.data_agenda, agenda.veiculo " +
                                                                 "from agenda_veiculo_viagem_ordem_servico as avos " +
                                                                 "inner join agenda_veiculo as agenda on avos.agenda_veiculo = agenda.id " +
                                                                 "inner join ordem_servico as os on avos.ordem_servico = os.id " +
                                                                 "inner join cliente on os.cliente = cliente.id " +
                                                                 "inner join pacote on os.dimensao_pacote = pacote.id " +
                                                                 "inner join endereco_destino on os.endereco_destino = endereco_destino.id " +
                                                                 "inner join endereco_origem on os.endereco_origem = endereco_origem.id " +
                                                                 "inner join veiculo on agenda.veiculo = veiculo.id " +
                                                                 "where avos.agenda_veiculo =  ?";
    private static final String ALTERA_VEICULO_EDICAO_FUNC_LOG = "update agenda_veiculo set veiculo=? where id=?";
    private static final String ALTERA_DATA_AGENDA_EDICAO_FUNC_LOG = "update agenda_veiculo set data_agenda=CAST(? as Date) where id=?";
    private static final String ALTERA_DATA_PARTIDA_OS_EDICAO_FUNC_LOG ="update ordem_servico set data_partida = CAST(? as Date) where id=?";
    private static final String ENCONTRA_ID_OS_EDICAO_FUNC_LOG = "select os.id as ordem_servico from agenda_veiculo_viagem_ordem_servico as avos inner join agenda_veiculo as agenda on avos.agenda_veiculo = agenda.id " +
                                                                 "inner join ordem_servico as os on avos.ordem_servico = os.id " +
                                                                 "where avos.agenda_veiculo = ? ";
     private static final String RETORNA_DATA_PARA_COMPARACAO = "select data_agenda from agenda_veiculo where id = ?";
     private static final String CONSULTA_ENTRE_DATAS = "select agenda.id as agenda_veiculo, os.id as ordem_servico, cliente.nome, veiculo.modelo, veiculo.placa, os.valor_viagem, concat(endereco_origem.rua||', '||endereco_origem.numero||'- '||endereco_origem.bairro||'- '||endereco_origem.cidade) as EndOrigem,concat(endereco_destino.rua||', '||endereco_destino.numero||'- '||endereco_origem.bairro||'- '||endereco_origem.cidade) as EndDestino, " +
"pacote.metros_cubicos, agenda.data_agenda, agenda.veiculo, agenda.status " +
"from agenda_veiculo_viagem_ordem_servico as avos " +
"inner join agenda_veiculo as agenda on avos.agenda_veiculo = agenda.id " +
"inner join ordem_servico as os on avos.ordem_servico = os.id " +
"inner join cliente on os.cliente = cliente.id " +
"inner join pacote on os.dimensao_pacote = pacote.id " +
"inner join endereco_destino on os.endereco_destino = endereco_destino.id " +
"inner join endereco_origem on os.endereco_origem = endereco_origem.id " +
"inner join veiculo on agenda.veiculo = veiculo.id " +
"where agenda.status=? and agenda.data_agenda between CAST(? as Date) and CAST(? as Date) " +
"order by agenda.data_agenda ";
     
     
    public void cadastraViagem(Agenda_Veiculo agVeic, Ordem_Servico os) throws SQLException {

        Connection conexao = null;
        PreparedStatement comando = null;
        try {
            conexao = ConectaBanco.getConexao();
            comando = conexao.prepareStatement(INSERE_VIAGEM);
            Viagem viagem = new Viagem();
            viagem.setStatus_viagem(Status_Frete.PENDENTE);

            comando.setInt(1, agVeic.getId());
            comando.setInt(2, os.getId());
            comando.setString(3, viagem.getStatus_viagem().toString());

            ResultSet resultadoPk = comando.executeQuery();

            if (resultadoPk.next()) {
                agVeic.setId(resultadoPk.getInt("id"));
            }
            //nao tinha salvo rs
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
    }

    public Viagem consultarPorIdOrdemServico(Viagem viagem) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_OS_DA_AGENDA);
        comando.setInt(1, viagem.getAgenda_veiculo().getId());

        ResultSet resultado = comando.executeQuery();

        while (resultado.next()) {

            viagem.getOrdem_servico().setId(resultado.getInt("ordem_servico"));
            viagem.getOrdem_servico().setMetros_cubico(resultado.getDouble("metros_cubicos"));
            viagem.getAgenda_veiculo().setData_agenda(resultado.getString("data_agenda"));
            viagem.setId(resultado.getInt("id"));
            viagem.getAgenda_veiculo().setVeiculo(resultado.getInt("veiculo"));

        } 

        con.close();
        return viagem;

    }
    
    
    
     public void alterarStatusViagens(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_STATUS_VIAGENS_ANTIGAS);

            
            pstm.setString(1, viagem.getStatus_viagem().toString() );
            pstm.setInt(2, viagem.getId());

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
     
     public void cadastraNovasViagens(Viagem viagem) throws SQLException {

        Connection conexao = null;
        PreparedStatement comando = null;
        try {
            conexao = ConectaBanco.getConexao();
            comando = conexao.prepareStatement(INSERE_VIAGEM_NOVA);

            viagem.setStatus_viagem(Status_Frete.PENDENTE );
        //    comando.setInt(1, viagem.getAgenda_veiculo().getId());
            comando.setInt(1, viagem.getOrdem_servico().getId());
            comando.setString(2, viagem. getStatus_viagem().toString());
           

            ResultSet resultadoPk = comando.executeQuery();

            if (resultadoPk.next()) {
                viagem.setId(resultadoPk.getInt("id"));
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
    }
       public void alteraViagensNovas(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_VIAGENS_NOVAS);

            
            pstm.setInt(1, viagem.getAgenda_veiculo().getId() );
            pstm.setInt(2, viagem.getId());

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
       
       public List<Viagem> consultaDetalhesViagemFuncLogistica(Viagem viagem) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(EXIBE_DETALHES_VIAGEM_FUNC_LOG);
        comando.setInt(1, viagem.getAgenda_veiculo().getId());

        ResultSet resultado = comando.executeQuery();
        List<Viagem> retornaViagens = new ArrayList<Viagem>();
        while (resultado.next()) {
            Viagem v = new Viagem();
            v.getAgenda_veiculo().setId(resultado.getInt("agenda_veiculo"));
            v.getOrdem_servico().setId(resultado.getInt("ordem_servico"));
            v.getOrdem_servico().setMetros_cubico(resultado.getDouble("metros_cubicos"));
            v.getAgenda_veiculo().setData_agenda(resultado.getString("data_agenda"));
            v.getAgenda_veiculo().setVeiculo(resultado.getInt("veiculo"));
            v.getOrdem_servico().setNome_cliente(resultado.getString("nome"));
            v.getAgenda_veiculo().setModelo_veic(resultado.getString("modelo"));
            v.getAgenda_veiculo().setPlaca_veic(resultado.getString("placa"));
            v.getOrdem_servico().setValor_viagem(resultado.getDouble("valor_viagem"));
            v.getOrdem_servico().setRua_origem(resultado.getString("endorigem"));
            v.getOrdem_servico().setRua_destino(resultado.getString("enddestino"));
            
            retornaViagens.add(v);

        } 

        con.close();
        return retornaViagens;

    }
       public void alterarVeiculoAgendaFuncEdicao(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ALTERA_VEICULO_EDICAO_FUNC_LOG);

            
            pstm.setInt(1, viagem.getAgenda_veiculo().getVeiculo() );
            pstm.setInt(2, viagem.getAgenda_veiculo().getId());

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
        public void alterarDataAgendaVeiculoFuncLog(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ALTERA_DATA_AGENDA_EDICAO_FUNC_LOG);

            
            pstm.setString(1, viagem.getAgenda_veiculo().getData_agenda() );
            pstm.setInt(2, viagem.getAgenda_veiculo().getId());

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
         public void alterarDataPartidaOsFuncLog(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ALTERA_DATA_PARTIDA_OS_EDICAO_FUNC_LOG);

            
            pstm.setString(1, viagem.getOrdem_servico().getData_partida() );
            pstm.setInt(2, viagem.getOrdem_servico().getId() );

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
public List<Viagem> consultaIdOsEdicaoFuncLog(Viagem viagem) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(ENCONTRA_ID_OS_EDICAO_FUNC_LOG);
        comando.setInt(1, viagem.getAgenda_veiculo().getId());

        ResultSet resultado = comando.executeQuery();
        List<Viagem> retornaViagens = new ArrayList<Viagem>();
        while (resultado.next()) {
            Viagem v = new Viagem();
            v.getOrdem_servico().setId(resultado.getInt("ordem_servico"));
            
            
            retornaViagens.add(v);

        } 

        con.close();
        return retornaViagens;

    }
public Viagem consultaDatasParaComparacao(Viagem viagem) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(RETORNA_DATA_PARA_COMPARACAO);
        comando.setInt(1, viagem.getAgenda_veiculo().getId());

        ResultSet resultado = comando.executeQuery();
        

       Viagem v = new Viagem();
        while (resultado.next()) {
           String retorno = null;
            
            v.getAgenda_veiculo().setData_agenda(resultado.getString("data_agenda"));
            
          }

          con.close();
          return v;
}
 public void alterarStatusAgendaQuandoConfirma(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_STATUS_AGENDA_VEICULO_QUANDO_CONFIRMA);

            
            pstm.setString(1, viagem.getAgenda_veiculo().getStatus_agenda().toString() );
            pstm.setInt(2, viagem.getAgenda_veiculo().getId());

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

public void alterarStatusViagemQuandoConfirma(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_STATUS_VIAGEM_QUANDO_CONFIRMA);

            
            pstm.setString(1, viagem.getStatus_viagem().toString() );
            pstm.setInt(2, viagem.getAgenda_veiculo().getId());

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
    public void alterarStatusOsQuandoConfirma(Viagem viagem) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_STATUS_ORDEM_SERVICO_QUANDO_CONFIRMA);

            
            pstm.setString(1, viagem.getOrdem_servico().getStatus_os().toString() );
            pstm.setInt(2, viagem.getOrdem_servico().getId());

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
    
    public List<Viagem> consultaDetalhesViagemFuncAdmin(String data1, String data2, String status) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_ENTRE_DATAS);
        comando.setString(1, status.toString() );    
        comando.setString(2, data1 );
        comando.setString(3, data2 );
            

        ResultSet resultado = comando.executeQuery();
        List<Viagem> retornaViagens = new ArrayList<Viagem>();
        while (resultado.next()) {
            Viagem v = new Viagem();
            v.getAgenda_veiculo().setId(resultado.getInt("agenda_veiculo"));
            v.getOrdem_servico().setId(resultado.getInt("ordem_servico"));
            v.getOrdem_servico().setMetros_cubico(resultado.getDouble("metros_cubicos"));
            v.getAgenda_veiculo().setData_agenda(resultado.getString("data_agenda"));
            v.getAgenda_veiculo().setVeiculo(resultado.getInt("veiculo"));
            v.getOrdem_servico().setNome_cliente(resultado.getString("nome"));
            v.getAgenda_veiculo().setModelo_veic(resultado.getString("modelo"));
            v.getAgenda_veiculo().setPlaca_veic(resultado.getString("placa"));
            v.getOrdem_servico().setValor_viagem(resultado.getDouble("valor_viagem"));
            v.getOrdem_servico().setRua_origem(resultado.getString("endorigem"));
            v.getOrdem_servico().setRua_destino(resultado.getString("enddestino"));
            v.getAgenda_veiculo().setStatus(resultado.getString("status"));
            
            retornaViagens.add(v);

        } 

        con.close();
        return retornaViagens;

    }
}
