package kr.bit.controller;

import kr.bit.entity.StudentStatus;
import kr.bit.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
public class StudentController {

    @Autowired
    private StudentMapper studentMapper;

    @DeleteMapping("/studentDelete/{stu_no}")
    public void studentDelete(@PathVariable("stu_no") int stu_no){
        studentMapper.studentDelete(stu_no);
    }

    @PutMapping("/update")
    public void update(@RequestBody StudentStatus studentStatus){
        System.out.println(1);
        studentMapper.update(studentStatus);
    }

    @PostMapping("/insert")
    public void insert(@RequestBody StudentStatus studentStatus){
        studentMapper.insert(studentStatus);
    }

}
