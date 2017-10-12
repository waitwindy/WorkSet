package com.ultrapower.crud.service;

import com.ultrapower.crud.bean.Department;
import com.ultrapower.crud.bean.Msg;
import com.ultrapower.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts() {

        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
