package com.atguigu.crud.service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 查询所有的部门信息
     * @return
     */
    public List<Department> getDepts() {
        //查出所有的部门信息
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
