package com.ultrapower.crud.test;


import com.ultrapower.crud.bean.Employee;
import com.ultrapower.crud.service.EmployeeService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class ServiceTest {
    @Autowired
    EmployeeService employeeService;
    @Test
    public void testEmployService (){
        List<Employee> all = employeeService.getAll();
        System.out.print(all);
    }

}
