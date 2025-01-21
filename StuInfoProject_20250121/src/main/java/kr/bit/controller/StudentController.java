package kr.bit.controller;

import kr.bit.entity.StudentList;
import kr.bit.entity.StudentStatus;
import kr.bit.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
public class StudentController {

    @Autowired
    private StudentMapper studentMapper;



    @DeleteMapping("/studentDelete/{stu_no}")
    public Map<String, Object> studentDelete(@PathVariable("stu_no") int stu_no){

        Map<String, Object> response = new HashMap<>();

        if(stu_no==0) {
            {
                response.put("messageType", "실패");
                response.put("message", "학생을 선택해야 합니다.");
                return response;
            }
        }
        studentMapper.studentDelete(stu_no);
        response.put("messageType", "성공");
        response.put("message", "성공적으로 삭제 되었습니다.");
        return response;
    }


    @ResponseBody
    @PutMapping("/update")
    public Map<String, Object> update(@RequestBody StudentStatus studentStatus){

        Map<String, Object> response = new HashMap<>();

        if (studentStatus.getStu_no()==0 ||
                studentStatus.getStu_name().equals("") || studentStatus.getStu_name().equals("null")
                || studentStatus.getStu_name().equals("") ||  studentStatus.getStu_name().equals("null")
                || studentStatus.getStu_addr().equals("") ||  studentStatus.getStu_addr().equals("null")
                || studentStatus.getStu_school().equals("") ||  studentStatus.getStu_school().equals("null")
                || studentStatus.getStu_major().equals("") ||  studentStatus.getStu_major().equals("null"))
        {
            response.put("messageType", "실패");
            response.put("message", "값을 모두 입력해주세요.");
            return response;
        }
        studentMapper.update(studentStatus);
        response.put("messageType", "성공");
        response.put("message", "성공적으로 수정 되었습니다.");
        return response;
    }


    @ResponseBody
    @PostMapping("/insert")
    public Map<String, Object> insert(@RequestBody StudentStatus studentStatus){

        Map<String, Object> response = new HashMap<>();

        if (studentStatus.getStu_name().equals("") || studentStatus.getStu_name().equals("null")
                || studentStatus.getStu_name().equals("") ||  studentStatus.getStu_name().equals("null")
                || studentStatus.getStu_addr().equals("") ||  studentStatus.getStu_addr().equals("null")
            || studentStatus.getStu_school().equals("") ||  studentStatus.getStu_school().equals("null")
            || studentStatus.getStu_major().equals("") ||  studentStatus.getStu_major().equals("null"))
        {
            response.put("messageType", "실패");
            response.put("message", "값을 모두 입력해주세요.");
            return response;
        }
        studentMapper.insert(studentStatus);
        response.put("messageType", "성공");
        response.put("message", "성공적으로 등록 되었습니다.");
        return response;
    }

    @ResponseBody
    @GetMapping("/getList")
    public Map<String, Object> getList(@RequestParam("stu_list_name") String stu_list_name) {
        // 응답 데이터를 담을 Map 객체 생성
        Map<String, Object> response = new HashMap<>();

        // 검색어가 비어 있는 경우 처리
        if (stu_list_name == null || stu_list_name.trim().isEmpty()) {
            response.put("messageType", "실패");
            response.put("message", "검색어를 입력해주세요.");
            return response;
        }

        // 검색 결과 가져오기
        List<StudentList> list = studentMapper.getList(stu_list_name);

        // 검색 결과가 없을 경우 처리
        if (list == null || list.isEmpty()) {
            response.put("messageType", "실패");
            response.put("message", "검색 결과가 없습니다.");
            response.put("data", new ArrayList<>()); // 빈 ArrayList 반환
            return response;
        }

        // 데이터 변환 및 응답 구성
        List<Map<String, Object>> result = new ArrayList<>();
        for (StudentList student : list) {
            Map<String, Object> studentData = new HashMap<>();
            studentData.put("stu_list_no", student.getStu_list_no());
            studentData.put("stu_list_name", student.getStu_list_name());
            result.add(studentData);
        }

        // 성공적인 응답 구성
        response.put("messageType", "성공");
        response.put("message", "성공적으로 불러왔습니다.");
        response.put("data", result);

        return response;
    }
    @GetMapping("/getInformation")
    public StudentStatus getInformation(@RequestParam("stu_list_no")int stu_list_no) {
        return studentMapper.getInformation(stu_list_no);
    }


}
