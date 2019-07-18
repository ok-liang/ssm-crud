package com.atguigu.crud.test;

import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试dao层的工作
 * 使用Spring的Junit的单元测试，要测试什么功能，就注入相应的组件。
 *      1、导入Spring-test模块到maven中。
 *      2、使用此注解@ContextConfiguration指定spring配置文件的位置
 *      3、使用@Runwith注解，替换成Spring的Junit
 *      4、直接用 @Autowired 注入我们需要的组件即可使用。
 */
@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired

    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSessionTemplate sqlSession; //能执行批量的sqlSession
    /**
     * 测试DepartMentMapper
     */
    @Test
    public void testCRUD(){
        //1、部门的插入
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //2、员工的插入
        //employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));

        //3、批量插入多个员工数据
       /* EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0; i<1000; i++){
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
        }
        System.out.println("批量完成");*/
    }
}
