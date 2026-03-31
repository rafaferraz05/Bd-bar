package com.rafael.bar.controller;

import com.rafael.bar.util.ConnectionFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class BancoController {
	
	 @GetMapping("/banco")
	    public String testarBanco() {
	        try {
	            ConnectionFactory.getConnection();
	            return "Conexão com o banco realizada com sucesso!";
	        } catch (Exception e) {
	            return "Erro ao conectar: " + e.getMessage();
	        }
	    }
	
}
