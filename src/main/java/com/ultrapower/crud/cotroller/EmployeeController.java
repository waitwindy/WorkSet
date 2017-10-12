package com.ultrapower.crud.cotroller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ultrapower.crud.bean.Employee;
import com.ultrapower.crud.bean.Msg;
import com.ultrapower.crud.dao.EmployeeMapper;
import com.ultrapower.crud.service.EmployeeService;
import org.apache.ibatis.annotations.Param;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*
* 处理员工的crud的请求
* */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
//     Logger logger= LoggerFactory.getLogger(EmployeeController.class);

    /**
     * 保存员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.saveEmp(employee);
//        logger.info("");
     return  Msg.success();
    }

    /**
     * 返回分页数据
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping("emps")
    @ResponseBody
    public Msg getEmpsWithJson(
            @RequestParam(value = "pn",defaultValue = "1") Integer pn,Model model
    ){
        PageHelper.startPage(pn, 5);
        List<Employee> emps =employeeService.getAll();
        /*将封装了分页信息的pageinfo对象传给前端就可以实现分也查询。*/
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return Msg.success().add("pageInfo",page);
    }

/*查询员工数据（分页查询）*/
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        /*引入pagehelper 分页插件*/
        PageHelper.startPage(pn, 5);
        List<Employee> emps =employeeService.getAll();
        /*将封装了分页信息的pageinfo对象传给前端就可以实现分也查询。*/
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

    return "/list";
    }

}
