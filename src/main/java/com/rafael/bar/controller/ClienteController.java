package com.rafael.bar.controller;

import com.rafael.bar.dao.ClienteDAO;
import com.rafael.bar.model.Cliente;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cliente")
public class ClienteController {

    @GetMapping
    public List<Cliente> listar() throws Exception {
        return new ClienteDAO().listar();
    }

    @PostMapping
    public String inserir(@RequestBody Cliente c) throws Exception {
        new ClienteDAO().inserir(c);
        return "Cliente inserido com sucesso!";
    }

    @PutMapping
    public String atualizar(@RequestBody Cliente c) throws Exception {
        new ClienteDAO().atualizar(c);
        return "Cliente atualizado com sucesso!";
    }

    @DeleteMapping("/{id}")
    public String remover(@PathVariable int id) throws Exception {
        new ClienteDAO().remover(id);
        return "Cliente removido com sucesso!";
    }
}