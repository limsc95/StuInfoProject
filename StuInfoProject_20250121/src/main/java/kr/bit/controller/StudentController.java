package kr.bit.controller;

import kr.bit.entity.StudentList;
import kr.bit.entity.StudentStatus;
import kr.bit.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

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

    @GetMapping("/getList")
    public List<StudentList> getList(@RequestParam("stu_list_name") String stu_list_name, RedirectAttributes rttr) {
        List<StudentList> list = studentMapper.getList(stu_list_name);

        if (list == null || list.isEmpty()) {

            rttr.addFlashAttribute("messageType", "불러오기 실패");
            rttr.addFlashAttribute("message", "등록되지 않은 이름입니다. <br>새로 입력하시겠습니까?");
            rttr.addFlashAttribute("modalStuName", stu_list_name);

            return list;
        }
        return list;
    }

    @GetMapping("/getInformation")
    public StudentStatus getInformation(@RequestParam("stu_list_no")int stu_list_no) {
        return studentMapper.getInformation(stu_list_no);
    }


}
