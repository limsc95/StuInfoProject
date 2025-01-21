package kr.bit.controller;

import kr.bit.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BoardController {

    @Autowired
    BoardMapper boardMapper;

    @RequestMapping("/")
    public String main(){
        return "main";
    }


}
