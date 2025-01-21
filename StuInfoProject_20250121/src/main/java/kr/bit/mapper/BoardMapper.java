package kr.bit.mapper;


import kr.bit.entity.Board;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper //mybatis api
public interface BoardMapper {

    public List<Board> getLists();



}
