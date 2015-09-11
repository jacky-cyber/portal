package com.ifunpay.test;

import com.ifunpay.util.common.ByteArrayUtil;

import java.util.AbstractMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Yu on 2015/3/4.
 */
public class TestForeach {
    public static void main(String... args){
        List<Byte> byteList = ByteArrayUtil.toList("abcafevaffadfeeddegf".getBytes());
        byteList.stream().collect(Collectors.groupingBy(b -> b)).forEach((aByte, bytes) -> {
                System.out.printf("%c, %d\n", aByte, bytes.stream().map(b -> 1).reduce((a, b) -> a+b).get());
        });


    }

    public static AbstractMap.SimpleEntry<Byte, Integer> map(Byte b){
        AbstractMap.SimpleEntry<Byte, Integer> e = new AbstractMap.SimpleEntry<>(b, 1);
        return e;
    }

    public static AbstractMap.SimpleEntry<Byte, Integer> reduce(AbstractMap.SimpleEntry<Byte, Integer> first, AbstractMap.SimpleEntry<Byte, Integer> second){
        return first;
    }
}
