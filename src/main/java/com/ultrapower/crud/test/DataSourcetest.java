package com.ultrapower.crud.test;

import com.ultrapower.crud.bean.Department;
import com.ultrapower.crud.bean.Employee;
import com.ultrapower.crud.dao.DepartmentMapper;
import com.ultrapower.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.junit.Test;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class DataSourcetest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testSource (){
        /**/
        System.out.print("测试 1 自动注入");
        System.out.println(departmentMapper);
    /*测试插入部门*/
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        departmentMapper.insertSelective(new Department(null,"研发部"));
//        departmentMapper.insertSelective(new Department(null,"产品部"));
//        departmentMapper.insertSelective(new Department(null,"销售部"));
//
//        /*测试插入员工*/
//        employeeMapper.insert(new Employee(null,"张三男","M","1234@1233.com",1));

//        for(){
//			employeeMapper.insertSelective(new Employee(null, , "M", "Jerry@atguigu.com", 1));
//		}
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i<1000;i++){
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null,uid, "M", uid+"@ultrapower.com", 1));
		}
		System.out.println("批量完成");

    }

}
