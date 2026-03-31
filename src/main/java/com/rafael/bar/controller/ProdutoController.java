package com.rafael.bar.controller;

import com.rafael.bar.dao.ProdutoDAO;
import com.rafael.bar.model.Produto;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/produto")
public class ProdutoController {

    @GetMapping
    public List<Produto> listar() throws Exception {
        return new ProdutoDAO().listar();
    }

    @PostMapping
    public String inserir(@RequestBody Produto p) throws Exception {
        new ProdutoDAO().inserir(p);
        return "Produto inserido com sucesso!";
    }

    @PutMapping
    public String atualizar(@RequestBody Produto p) throws Exception {
        new ProdutoDAO().atualizar(p);
        return "Produto atualizado com sucesso!";
    }

    @DeleteMapping("/{id}")
    public String remover(@PathVariable int id) throws Exception {
        new ProdutoDAO().remover(id);
        return "Produto removido com sucesso!";
    }
}