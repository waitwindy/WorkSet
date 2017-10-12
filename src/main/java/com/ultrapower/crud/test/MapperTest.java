package com.ultrapower.crud.test;

import com.ultrapower.crud.bean.Department;
import com.ultrapower.crud.dao.DepartmentMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Test
    public  void getDepart(){
        List<Department> list = departmentMapper.selectByExample(null);
        for (int i = 0; i <list.size() ; i++) {
            System.out.println(list.get(i).getDeptName());
        }

    }
}
