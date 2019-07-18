package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 更新员工信息。
     *     更新指定Id的那个员工的信息。
     *  REST风格URL的使用：
     *      1)若 参数value = "/emp/{empId}"中的路径变量跟 要绑定的变量名一致，那么就不用使用 这个注解
     *      ， @PathVariable(name = "id") Integer id，进行变量名字的转换。
     *      2)URL路径中 携带的变量，也会绑定到Controller的接收参数中。key是value中的参数，值是发送的URL中的值。
     *
     *  如果直接发送Ajax=PUT的请求，只能把URL中的参数封装到Employee中。其余的参数都封装不上。
     *  封装的数据Employee
     *      [empId=1014, empName=null, gender=null, email=null, dId=null]
     *
     *  问题：请求体中携带有数据，封装不到接收参数(Employee)上。// 就会导致控制台错误。
     *  封装不到Employee中的话，更新SQL语句，就变成了：update tb1_emp where emp_id = 1014; //整个SQL语句是错误的。
     *  原因：是Tomcat的问题。
     *
     *
     *
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 获取指定id 的Employee信息并返回。
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable(name = "empId")Integer empId){
        Employee employee =  employeeService.getEmp(empId);
        return Msg.success().add("emp",employee);
    }

    /**
     * 查询员工数据(分页查询)
     *      1、把数据 以Json格式返回。//这样做的前提是：导入jackson包。
     * @param pn 第几页的数据。
     * @return Msg(包含查询数据信息.处理状态的信息的通用类)
     */
    @RequestMapping(value = "/emps")
    @ResponseBody       //把数据 以Json格式返回。
    public Msg getEmpsWithJson(@RequestParam(name = "pn", defaultValue = "1") Integer pn) {
        //这不是一个分页查询
        //我们引入PageHelper分页插件
        //在查询之前只需要只需要调用,传入页码，以及每一页展示的数据条数pageSize。
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询。//数据包括：查出来的结果：数据库的数据 + 相关信息。
        List<Employee> emps = employeeService.getAll();
        //创建PageInfo对象 包装查询后的结果 和传入连续显示的页数。然后只需要将pageInfo交给页面就行了。
        //PageInfo对象封装了详细的分页信息,包括我们查询出来的数据。(如：当前是第几页？总共有多少页？有没有下一页？等等)
        PageInfo pageInfo = new PageInfo(emps, 5);

        //把数据以 json字符串形式返回给客户端。
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 保存员工信息
     *  1、支持JSR303校验
     *  2、需要导入Hibernate-Validator 这个包，这是对JSR303的实现。
     * @Valid 对接收的前端数据进行验证。
     * BindingResult result 保存验证的结果。
     *
     * 使用REST风格的URL，method为POST。
     *      method = RequestMethod.POST
     *
     */
    @RequestMapping(value = "/emps",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        //校验失败，返回失败信息。在模态框中显示校验失败的错误信息。
        if(result.hasErrors()){
            Map<Object, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fielderror : errors) {
                System.out.println("错误的字段名：" + fielderror.getField());
                System.out.println("错误信息：" + fielderror.getDefaultMessage());
                map.put(fielderror.getField(),fielderror.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{//校验成功
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检验用户名是否可用
     *      可用，返回给浏览一个success（）。
     *      不可以。返回faile（）。
     */
    @ResponseBody
    @RequestMapping(value = "/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){
        //格式验证 和 用户名是否可用验证 进行统一。先验证格式，再验证名字是否可用。
        //1.判断用户名 格式是否正确。
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名格式不正确");
        }
        //2.验证Name是否可用。
        boolean b  = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    /**
     * 根据员工Id 删除员工————————因为REST请求只能带一个empId，则需要对方法进行改造。删除单个、批量 二合一。
     *      把传入的参数设置为String类型。
     * 删除多个员工：1-2-3-4
     * 删除单个员工：1
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        //批量删除
        if(ids.contains("-")){
            String[] str_ids = ids.split("-");
            ArrayList<Integer> idList = new ArrayList<>();
            for (String str_id : str_ids) {
                idList.add(Integer.parseInt(str_id));
            }
            //调用批量删除的service方法
            employeeService.deleteBatch(idList);
        }else{//单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }
        return Msg.success();
    }
}
