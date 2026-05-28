package com.rafael.bar.controller;

import com.rafael.bar.dao.ComandaDAO;
import com.rafael.bar.model.Comanda;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comanda")
public class ComandaController {

    @GetMapping
    public List<Comanda> listar() throws Exception {
        return new ComandaDAO().listar();
    }

    @PostMapping
    public String inserir(@RequestBody Comanda c) throws Exception {
        new ComandaDAO().inserir(c);
        return "Comanda aberta com sucesso!";
    }

    @PutMapping
    public String atualizar(@RequestBody Comanda c) throws Exception {
        new ComandaDAO().atualizar(c);
        return "Comanda atualizada com sucesso!";
    }

    @DeleteMapping("/{id}")
    public String remover(@PathVariable int id) throws Exception {
        new ComandaDAO().remover(id);
        return "Comanda removida com sucesso!";
    }
}