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
import static jdk.nashorn.internal.runtime.Debug.id;
import util.ConectaBanco;

/**
 *
 * @author Ramon Cordeiro
 */
public class Ordem_ServicoDAO {

    private static final String CADASTRA_ORDEM_SERVICO_PARCIAL_CLIENTE = "insert into ordem_servico (cliente,data_partida,endereco_origem,endereco_destino,dimensao_pacote,km_percorrido,veiculo)values (?,?,?,?,?,?,?) returning id";
    private static final String ATUALIZA_VALOR_FRETE = "UPDATE ordem_servico set valor_viagem = ? where id = ? ";
    private static final String ATUALIZA_VEICULO_FRETE = "UPDATE ordem_servico set veiculo = ? where id = ? ";
    private static final String ATUALIZA_MOTORISTA_FRETE = "UPDATE ordem_servico set motorista =? where id=?";
    private static final String CONSULTA_TODAS_OS = "select Os.id, Cli.nome,Veic.marca , Veic.modelo,Os.data_partida,Os.valor_viagem\n" +
                                                    "from ordem_servico as Os, cliente as Cli, veiculo as Veic\n" +
                                                    "where Os.cliente = Cli.id and Os.veiculo = Veic.id";
    private static final String VERIFICA_DISPONIBILIDADE_OS =  "select veiculo.* from veiculo where veiculo.tipo = ? and veiculo.id not in (select agenda_veiculo.veiculo from agenda_veiculo where agenda_veiculo.data_fim > ?::date)";

    private static final String CLIENTE_CONSULTA_OS = "select ordem_servico.id as numeroFrete,cliente.nome as Cliente, ordem_servico.data_partida as Data_Frete,endereco_origem.rua as Rua_Origem,endereco_destino.rua as Rua_Destino, ordem_servico.valor_viagem, ordem_servico.km_percorrido, ordem_servico.status from ordem_servico join cliente on ordem_servico.cliente = cliente.id join endereco_origem on ordem_servico.endereco_origem = endereco_origem.id join endereco_destino on ordem_servico.endereco_destino = endereco_destino.id where cliente.id = ?"; 
    private static final String ALTERA_STATUS_OS = "update ordem_servico set status=? where id=?";                                                 
   
                                                     
                                                     
                                                     

    
    
    public void cadastrarOrdemServico(Ordem_Servico os, Endereco_Origem endereco_origem, Endereco_Destino endereco_destino, Pacote pacote) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        try {
            conexao = ConectaBanco.getConexao();
            pstmt = conexao.prepareStatement(CADASTRA_ORDEM_SERVICO_PARCIAL_CLIENTE);
            pstmt.setInt(1, os.getCliente());
            pstmt.setString(2, os.getData_partida() );
            pstmt.setInt(3, endereco_origem.getId());
            pstmt.setInt(4, endereco_destino.getId());
            pstmt.setInt(5, pacote.getId());
            pstmt.setDouble(6, os.getKm_percorrido());
            pstmt.setInt(7, os.getVeiculo());

           ResultSet resultadoPk = pstmt.executeQuery(); 
           
           if(resultadoPk.next()){
                    os.setId(resultadoPk.getInt("id"));
                }
            

        } catch (SQLException sqlErro) {
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

    public Ordem_Servico setValorViagem(Ordem_Servico os) {

        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_VALOR_FRETE);

            pstm.setDouble(1, os.getValor_viagem());

            pstm.setInt(2, os.getId());

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
        return os;
    }
     public Ordem_Servico setVeiculoViagem(Ordem_Servico os, Veiculo veiculo) {

        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_VEICULO_FRETE);

            pstm.setInt(1, veiculo.getId());

            pstm.setInt(2, os.getId());

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
        return os;
    }
     
     
       public List<Ordem_Servico> listarOrdemServico() throws ClassNotFoundException, SQLException {

         Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_TODAS_OS);
        

        ResultSet resultado = comando.executeQuery();

        List<Ordem_Servico> todasOs = new ArrayList<Ordem_Servico>();
        while (resultado.next()) {
            Ordem_Servico os = new Ordem_Servico();
            
            os.setId(resultado.getInt("id"));
            os.setNome_cliente(resultado.getString("Cli.nome"));
            os.setModelo_veiculo(resultado.getString("Veic.modelo"));
            os.setMarca_veiculo(resultado.getString("Veic.marca"));
            os.setData_partida(resultado.getString("Os.data_partida"));
            os.setValor_viagem(resultado.getInt("Os.valor_viagem"));
            
            
            
            todasOs.add(os);

        }

        con.close();
        return todasOs;

    }
       public List<Ordem_Servico> consultaOrdemServicoCliente(Cliente cliente) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CLIENTE_CONSULTA_OS);
        comando.setInt(1, cliente.getId());

        ResultSet resultado = comando.executeQuery();
        

       List <Ordem_Servico> ordem_servico = new ArrayList <Ordem_Servico>();
        while (resultado.next()) {
            Ordem_Servico os = new Ordem_Servico();
            os.setKm_percorrido(resultado.getDouble("km_percorrido"));
            os.setNome_cliente(resultado.getString("Cliente")); 
            os.setData_partida(resultado.getString("data_frete"));
            os.setRua_origem(resultado.getString("rua_origem"));
            os.setRua_destino(resultado.getString("rua_destino"));
            os.setValor_viagem(resultado.getDouble("valor_viagem"));
            os.setId(resultado.getInt("numerofrete"));//BOA
            os.setStatus(resultado.getString("status"));
            ordem_servico.add(os);

        }

          con.close();
          return ordem_servico;
}
        public void setStatusOs(Ordem_Servico os) {

        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ALTERA_STATUS_OS);

            pstm.setString(1, os.getStatus_os().toString() );

            pstm.setInt(2, os.getId());

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
        
}


