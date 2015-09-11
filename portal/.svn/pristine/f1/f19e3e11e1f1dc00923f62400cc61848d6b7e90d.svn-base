package com.ifunpay.test;

import java.util.Arrays;

/**
 * Created by Yu on 2015/2/13.
 */
public class TestMain {

    private static void printf(String pattern, Object... args) {
        System.out.printf(pattern, args);
    }

    public static final void p(Object... args){
        Arrays.stream(args).forEach(System.out::println);
    }

    public static void fed(){
        for (int i = 1, j = 1, k = 1, l = 1; i < 31; j = k, k += l, l = j) printf("%d:%d\n", i++, j);
    }

    public static int testFinally(){
        int i = 1;
        i = (i++);
        try{
            return i;
        }finally {
            i = 3;
            return i;
        }
    }

    public static void main(String... args) throws CloneNotSupportedException {
        class A implements Cloneable{
            int a = 1;

            @Override
            public Object clone() throws CloneNotSupportedException {
                return super.clone();
            }
        }

        class B extends A{

        }
        A a = new A();
        B b = (B) a.clone();
        p(b);
    }
}
