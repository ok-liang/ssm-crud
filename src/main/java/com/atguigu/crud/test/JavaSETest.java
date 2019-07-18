package com.atguigu.crud.test;

import java.util.Arrays;

public class JavaSETest {
    public static void main(String[] args) {
        String str = "1-2-3-4";
        String[] strings = str.split("-");
        System.out.println(Arrays.toString(strings));
    }
}
