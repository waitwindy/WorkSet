package com.ultrapower.crud.service;

import com.ultrapower.crud.bean.Employee;
import com.ultrapower.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     *  查询所有的
     * @return
     */
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee emloyee) {
        employeeMapper.insertSelective(emloyee);
    }
}
