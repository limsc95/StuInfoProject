package kr.bit.mapper;

import kr.bit.entity.StudentList;
import kr.bit.entity.StudentStatus;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StudentMapper {

    public List<StudentList> getList(String stu_name);
    public StudentStatus getInformation(int stu_no);

    public void insert(StudentStatus studentStatus);
    public void update(StudentStatus studentStatus);
    public void studentDelete(int stu_no);

}
