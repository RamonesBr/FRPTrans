/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ramon Cordeiro
 */
public class Pacote {

    private int id;
    private double comprimento;
    private double altura;
    private double largura;
    private double peso;
    private String tipo;
    private double metros_cubicos;

    public double getMetros_cubicos() {
        return metros_cubicos;
    }

    public void setMetros_cubicos(double metros_cubicos) {
        this.metros_cubicos = metros_cubicos;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getComprimento() {
        return comprimento;
    }

    public void setComprimento(double comprimento) {
        this.comprimento = comprimento;
    }

    public double getAltura() {
        return altura;
    }

    public void setAltura(double altura) {
        this.altura = altura;
    }

    public double getLargura() {
        return largura;
    }

    public void setLargura(double largura) {
        this.largura = largura;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Pacote classificaPacote(Pacote pacote) {

        double altura = pacote.getAltura();
        double largura = pacote.getLargura();
        double comprimento = pacote.getComprimento();
        double peso = pacote.getPeso();

        double m = altura * largura * comprimento;
        double p = peso;

        
        if (p <= 30) {    //compara o peso, nessa faixa de peso todos os veiculos suportam 
            if (m <= 1) {
                this.tipo = "A";
            } else if (m > 1 && m <= 6) {
                this.tipo = "B";
            } else if (m > 6 && m <= 12) {
                this.tipo = "C";
            } else if (m > 12 && m <=168 ) {   //colocar limite 
                this.tipo = "D";
            }

        } else if(p>30 && p<=450) { // nessa faixa de peso, apenas as motos não suportam 
            if (m <= 6) {
                this.tipo = "B";
            } else if (m > 6 && m <= 12) {
                this.tipo = "C";
            } else if (m > 12 && m <=168) {   //colocar limite 
                this.tipo = "D";
            }
            
        } else if (p >450 && p<=1600){  // nessa faixa de peso, motos e carros não suportam 
            if (m <= 12) {
                this.tipo = "C";
            } else if (m > 12 && m <=168) {   //colocar limite 
                this.tipo = "D";
            }
        }else if (p > 1600 && p <=23000){ // nessa faixa de peso as motos, carros e Hr's não suportam
            if (m <=168){
                this.tipo = "D";
            }
            
        }
        
        pacote.setMetros_cubicos(m);
        pacote.setTipo(this.tipo);
       
        
        
        
        
        return pacote;
    }

}
