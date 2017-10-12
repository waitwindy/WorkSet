package com.ultrapower.crud.cotroller;

import com.ultrapower.crud.bean.Department;
import com.ultrapower.crud.bean.Msg;
import com.ultrapower.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 */
@SuppressWarnings("ALL")
@Controller
public class DepartmentCotroller {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有的部门信息
     *
     */

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
      List<Department> list= departmentService.getDepts();

        return Msg.success().add("depts",list);
        }

}
